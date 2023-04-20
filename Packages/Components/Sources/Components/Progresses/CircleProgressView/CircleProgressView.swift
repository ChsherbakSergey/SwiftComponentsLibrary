//  Created by Sergey Chsherbak on 14/04/2023.

import UIKit

public final class CircleProgressView: UIView {

    // MARK: - Public Properties

    public var trackTintColor: UIColor = .systemBlue.withAlphaComponent(0.25) {
        didSet {
            trackLayer.strokeColor = trackTintColor.cgColor
            trackLayer.setNeedsDisplay()
        }
    }

    public var progressTintColor: UIColor = .systemBlue {
        didSet {
            progressLayer.strokeColor = progressTintColor.cgColor
            progressLayer.setNeedsDisplay()
        }
    }

    public var lineCap: CAShapeLayerLineCap = .round {
        didSet {
            trackLayer.lineCap = lineCap
            trackLayer.setNeedsDisplay()
            progressLayer.lineCap = lineCap
            progressLayer.setNeedsDisplay()
        }
    }

    public var width: CGFloat = 20 {
        didSet {
            trackLayer.lineWidth = width
            trackLayer.setNeedsDisplay()
            progressLayer.lineWidth = width
            progressLayer.setNeedsDisplay()
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

    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()

    private var progressValue: CGFloat = 0.0

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupSublayers()
        updateLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    public func setProgress(to value: Double, animated: Bool) {
        if animated {
            setAnimatedProgress(to: value)
        } else {
            setProgress(to: value)
        }
    }

    // MARK: - Private Methods

    private func setAnimatedProgress(to value: Double) {
        if let progressValue = progressLayer.presentation()?.strokeEnd {
            self.progressValue = progressValue
        }
        progressLayer.strokeEnd = value

        let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        animation.fromValue = progressValue
        animation.duration = animationDuration
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)

        progressLayer.add(animation, forKey: animation.keyPath)
    }

    private func setProgress(to value: Double) {
        progressLayer.removeAllAnimations()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        progressLayer.strokeEnd = value
        CATransaction.commit()
    }

    private func setup() {
        backgroundColor = .systemBackground
        layer.contentsScale = window?.windowScene?.screen.scale ?? 0
    }

    private func setupSublayers() {
        trackLayer.contentsScale = window?.windowScene?.screen.scale ?? 0
        progressLayer.contentsScale = window?.windowScene?.screen.scale ?? 0
        layer.addSublayer(trackLayer)
        layer.addSublayer(progressLayer)
    }

    private func updateLayout() {
        updateTrackLayer()
        updateProgressLayer()
    }

    private func updateTrackLayer() {
        let path = makePath()
        trackLayer.frame = bounds
        trackLayer.path = path.cgPath
        trackLayer.fillColor = nil
        trackLayer.lineWidth = width
        trackLayer.lineCap = lineCap
        trackLayer.strokeColor = trackTintColor.cgColor
        trackLayer.strokeEnd = 1
    }

    private func updateProgressLayer() {
        let path = makePath()
        progressLayer.frame = bounds
        progressLayer.path = path.cgPath
        progressLayer.fillColor = nil
        progressLayer.lineWidth = width
        progressLayer.lineCap = lineCap
        progressLayer.strokeColor = progressTintColor.cgColor
        progressLayer.strokeEnd = 0
        progressLayer.transform = CATransform3DMakeRotation(90 * .pi / 180, 0, 0, -1)
    }

    private func makePath() -> UIBezierPath {
        let squareSize = min(bounds.width, bounds.height)
        let squareRect = CGRect(
            x: (bounds.width - squareSize) / 2,
            y: (bounds.height - squareSize) / 2,
            width: squareSize,
            height: squareSize
        )
        let width = min(self.width, squareSize / 2)
        let circleRect = squareRect.insetBy(dx: width / 2, dy: width / 2)
        let circlePath = UIBezierPath(ovalIn: circleRect)

        return circlePath
    }
}
