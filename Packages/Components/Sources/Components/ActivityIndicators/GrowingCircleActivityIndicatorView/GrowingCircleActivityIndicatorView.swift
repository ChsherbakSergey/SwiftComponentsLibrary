//  Created by Sergey Chsherbak on 14/04/2023.

import UIKit

public final class GrowingCircleActivityIndicatorView: UIView {

    // MARK: - Public Properties

    public var color: UIColor = .systemBlue {
        didSet {
            growingCircleLayer.strokeColor = color.cgColor
            growingCircleLayer.setNeedsDisplay()
        }
    }

    public var width: CGFloat = 2 {
        didSet {
            growingCircleLayer.lineWidth = width
            growingCircleLayer.setNeedsDisplay()
        }
    }

    public var lineCap: CAShapeLayerLineCap = .round {
        didSet {
            growingCircleLayer.lineCap = lineCap
            growingCircleLayer.setNeedsDisplay()
        }
    }

    public var animationDuration: TimeInterval = 1.5

    // MARK: - Overriden Properties

    public override var bounds: CGRect {
        didSet {
            guard bounds != oldValue else { return }

            updateLayout()
        }
    }

    // MARK: - Private Properties

    private let growingCircleLayer = CAShapeLayer()

    private var isAnimating: Bool = false

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupSublayers()
        updateLayout()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    public func startAnimating() {
        guard !isAnimating else { return }

        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1.0
        strokeStartAnimation.duration = animationDuration / 2
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        strokeStartAnimation.beginTime = animationDuration / 2

        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0.0
        strokeEndAnimation.toValue = 1.0
        strokeEndAnimation.duration = animationDuration
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [strokeEndAnimation, strokeStartAnimation]
        groupAnimation.duration = animationDuration
        groupAnimation.repeatDuration = .infinity

        growingCircleLayer.add(groupAnimation, forKey: nil)
        isAnimating = true
    }

    public func stopAnimating() {
        guard isAnimating else { return }

        growingCircleLayer.removeAllAnimations()
        isAnimating = false
    }

    // MARK: - Setup

    private func setup() {
        backgroundColor = .systemBackground
        layer.contentsScale = window?.windowScene?.screen.scale ?? 0
    }

    private func setupSublayers() {
        growingCircleLayer.contentsScale = window?.windowScene?.screen.scale ?? 0
        layer.addSublayer(growingCircleLayer)
    }

    private func updateLayout() {
        let squareSize = min(bounds.width, bounds.height)
        let squareRect = CGRect(
            x: (bounds.width - squareSize) / 2,
            y: (bounds.height - squareSize) / 2,
            width: squareSize,
            height: squareSize
        )
        let width = min(width, squareSize / 2)
        let circleRect = squareRect.insetBy(dx: width / 2, dy: width / 2)
        let circlePath = UIBezierPath(ovalIn: circleRect).cgPath

        growingCircleLayer.path = circlePath
        growingCircleLayer.fillColor = UIColor.clear.cgColor
        growingCircleLayer.lineWidth = width
        growingCircleLayer.strokeStart = 0
        growingCircleLayer.strokeEnd = 0
        growingCircleLayer.strokeColor = color.cgColor
        growingCircleLayer.lineCap = lineCap
    }
}
