//  Created by Sergey Chsherbak on 14/04/2023.

import UIKit

public final class StrokeProgressBarView: UIView {

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

    public var borderTintColor: UIColor = .systemBlue {
        didSet {
            borderLayer.borderColor = borderTintColor.cgColor
            borderLayer.setNeedsDisplay()
        }
    }

    public var borderWidth: CGFloat = 1 {
        didSet {
            borderLayer.borderWidth = borderWidth
            borderLayer.setNeedsDisplay()
        }
    }

    public var lineCap: CAShapeLayerLineCap = .round {
        didSet {
            trackLayer.lineCap = lineCap
            trackLayer.setNeedsDisplay()
            progressLayer.lineCap = lineCap
            progressLayer.setNeedsDisplay()
            borderCornerRadius = lineCap == .round ? bounds.height / 2 : 0
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

    private var borderCornerRadius: CGFloat = 0 {
        didSet {
            borderLayer.cornerRadius = borderCornerRadius
            borderLayer.setNeedsDisplay()
        }
    }

    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    private let borderLayer = CAShapeLayer()

    private var progressValue: CGFloat = 0.0

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

        let strokeEndAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        strokeEndAnimation.fromValue = progressValue
        strokeEndAnimation.duration = animationDuration
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)

        progressLayer.add(strokeEndAnimation, forKey: strokeEndAnimation.keyPath)
    }

    private func setProgress(to value: Double) {
        progressLayer.removeAllAnimations()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        progressLayer.strokeEnd = value
        CATransaction.commit()
    }

    // MARK: - Setup

    private func setup() {
        backgroundColor = .systemBackground
        layer.contentsScale = window?.windowScene?.screen.scale ?? 0
    }

    private func setupSublayers() {
        trackLayer.contentsScale = window?.windowScene?.screen.scale ?? 0
        progressLayer.contentsScale = window?.windowScene?.screen.scale ?? 0
        borderLayer.contentsScale = window?.windowScene?.screen.scale ?? 0
        layer.addSublayer(trackLayer)
        layer.addSublayer(progressLayer)
        layer.addSublayer(borderLayer)
    }

    private func updateLayout() {
        updateTrackLayer()
        updateProgressLayer()
        updateBorderLayer()
    }

    private func updateTrackLayer() {
        let path = makePath()
        trackLayer.frame = bounds
        trackLayer.path = path.cgPath
        trackLayer.fillColor = nil
        trackLayer.lineWidth = bounds.height
        trackLayer.lineCap = lineCap
        trackLayer.strokeColor = trackTintColor.cgColor
        trackLayer.strokeEnd = 1
    }

    private func updateProgressLayer() {
        let path = makePath()
        progressLayer.frame = bounds
        progressLayer.path = path.cgPath
        progressLayer.fillColor = nil
        progressLayer.lineWidth = bounds.height
        progressLayer.lineCap = lineCap
        progressLayer.strokeColor = progressTintColor.cgColor
        progressLayer.strokeEnd = 0
    }

    private func updateBorderLayer() {
        borderLayer.frame = bounds
        borderLayer.borderWidth = borderWidth
        borderLayer.borderColor = borderTintColor.cgColor
        borderLayer.cornerRadius = lineCap == .round ? bounds.height / 2 : 0
    }

    private func makePath() -> UIBezierPath {
        let path = UIBezierPath()
        let startX = lineCap == .round ? bounds.height / 2 : 0
        let endX = lineCap == .round ? (bounds.width - bounds.height / 2) : bounds.width
        let y = bounds.height / 2
        let startPoint = CGPoint(x: startX, y: y)
        let endPoint = CGPoint(x: endX, y: y)
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        return path
    }
}
