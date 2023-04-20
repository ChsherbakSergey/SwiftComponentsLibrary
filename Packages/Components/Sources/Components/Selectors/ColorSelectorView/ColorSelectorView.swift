//  Created by Sergey Chsherbak on 19/04/2023.

import UIKit

public final class ColorSelectorView: UIView {
    
    // MARK: - Public Properties
    
    public var baseBackgroundColor: UIColor = .systemBlue {
        didSet {
            circleLayer.fillColor = baseBackgroundColor.cgColor
            circleLayer.setNeedsDisplay()
        }
    }
    
    public var baseStrokeForegroundColor: UIColor = .tertiarySystemBackground {
        didSet {
            selectionLayer.strokeColor = baseStrokeForegroundColor.cgColor
            selectionLayer.setNeedsDisplay()
        }
    }
    
    public var strokeWidth: CGFloat = 2
    public var animationDuration: TimeInterval = 0.23
    
    // MARK: - Private Properties
    
    private var _strokeWidth: CGFloat = 0
    private var isSelected: Bool = false
    
    private let circleLayer = CAShapeLayer()
    private let coreCircleLayer = CAShapeLayer()
    private let selectionLayer = CAShapeLayer()
    
    // MARK: - Overriden Properties
    
    public override var bounds: CGRect {
        didSet {
            guard bounds != oldValue else { return }
            
            updateLayout()
        }
    }
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupSublayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateLayout()
    }
    
    // MARK: - Public methods
    
    public func select() {
        guard !isSelected else { return }
        
        isSelected = true
        selectionLayer.lineWidth = strokeWidth
        _strokeWidth = strokeWidth
        
        let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.lineWidth))
        animation.fromValue = 0
        animation.duration = animationDuration
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        selectionLayer.add(animation, forKey: animation.keyPath)
    }
    
    public func deselect() {
        guard isSelected else { return }
        
        isSelected = false
        selectionLayer.lineWidth = 0
        _strokeWidth = 0
        let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.lineWidth))
        animation.fromValue = strokeWidth
        animation.toValue = 0
        animation.duration = animationDuration
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        selectionLayer.add(animation, forKey: animation.keyPath)
    }
    
    // MARK: - Setup
    
    private func setup() {
        backgroundColor = .systemBackground
        layer.contentsScale = window?.windowScene?.screen.scale ?? 0
        layer.drawsAsynchronously = true
    }
    
    private func setupSublayers() {
        layer.addSublayer(circleLayer)
        layer.addSublayer(coreCircleLayer)
        layer.addSublayer(selectionLayer)
        circleLayer.contentsScale = window?.windowScene?.screen.scale ?? 0
        coreCircleLayer.contentsScale = window?.windowScene?.screen.scale ?? 0
        selectionLayer.contentsScale = window?.windowScene?.screen.scale ?? 0
    }
    
    private func updateLayout() {
        updateCircleLayerLayer()
        updateCoreCircleLayer()
        updateSelectionLayer()
    }
    
    private func updateCircleLayerLayer() {
        let squareSize = min(bounds.width, bounds.height)
        let squareRect = CGRect(
            x: (bounds.width - squareSize) / 2,
            y: (bounds.height - squareSize) / 2,
            width: squareSize,
            height: squareSize
        )
        let circlePath = UIBezierPath(ovalIn: squareRect).cgPath
        circleLayer.frame = bounds
        circleLayer.path = circlePath
        circleLayer.fillColor = baseBackgroundColor.cgColor
    }
    
    private func updateCoreCircleLayer() {
        let squareSize = min(bounds.width / 2, bounds.height / 2)
        let squareRect = CGRect(
            x: (bounds.width - squareSize) / 2,
            y: (bounds.height - squareSize) / 2,
            width: squareSize,
            height: squareSize
        )
        let circlePath = UIBezierPath(ovalIn: squareRect).cgPath
        coreCircleLayer.frame = bounds
        coreCircleLayer.path = circlePath
        coreCircleLayer.fillColor = UIColor.systemBackground.withAlphaComponent(0.35).cgColor
    }
    
    private func updateSelectionLayer() {
        let squareSize = min(bounds.width, bounds.height)
        let squareRect = CGRect(
            x: (bounds.width - squareSize) / 2,
            y: (bounds.height - squareSize) / 2,
            width: squareSize,
            height: squareSize
        )
        let circleRect = squareRect.insetBy(dx: squareSize / 8, dy: squareSize / 8)
        let circlePath = UIBezierPath(ovalIn: circleRect).cgPath
        selectionLayer.frame = bounds
        selectionLayer.path = circlePath
        selectionLayer.strokeColor = baseStrokeForegroundColor.cgColor
        selectionLayer.lineWidth = _strokeWidth
        selectionLayer.fillColor = nil
    }
}
