//  Created by Sergey Chsherbak on 21/04/2023.

import UIKit

public final class StepProgressBarView: UIView {
    
    // MARK: - Public Properties
    
    public var trackTintColor: UIColor = .systemBlue.withAlphaComponent(0.25) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var progressTintColor: UIColor = .systemBlue {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var spacing: CGFloat = 4 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var cornerRadius: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var stepsCount: Int = 4 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var progress: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: - Public Methods
    
    public func next() {
        progress = min(stepsCount, progress + 1)
    }
    
    public func previous() {
        progress = max(0, progress - 1)
    }
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    public override func draw(_ rect: CGRect) {
        var x: CGFloat = 0
        let width: CGFloat = (bounds.width - CGFloat(stepsCount - 1) * spacing) / CGFloat(stepsCount)
        for step in 1...stepsCount {
            let path = UIBezierPath(
                roundedRect: CGRect(x: x, y: 0, width: width, height: bounds.height),
                cornerRadius: max(0, min(cornerRadius, bounds.height / 2))
            )
            step <= progress ? progressTintColor.setFill() : trackTintColor.setFill()
            x += width + spacing
            path.fill()
        }
    }
    
    // MARK: - Setup
    
    private func setup() {
        backgroundColor = .systemBackground
    }
}
