//  Created by Sergey Chsherbak on 15/04/2023.

import UIKit

public final class RangeSlider: UIControl {
    
    // MARK: - Public Properties
    
    public var minimumValue: CGFloat = 0
    public var maximumValue: CGFloat = 1
    public var lowerValue: CGFloat = 0.25
    public var upperValue: CGFloat = 0.75
    
    // MARK: - Overriden Properties

    public override var bounds: CGRect {
        didSet {
            guard bounds != oldValue else { return }

            updateLayout()
        }
    }
    
    // MARK: - Private Properties
    
    private let trackLayer = CALayer()
    private let thumbImage = UIImage(systemName: "circle.fill")!
    private let lowerThumbImageView = UIImageView()
    private let upperThumbImageView = UIImageView()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupSublayers()
        updateLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .systemBackground
    }
    
    private func setupSublayers() {
        trackLayer.backgroundColor = UIColor.blue.cgColor
        layer.addSublayer(trackLayer)
        lowerThumbImageView.image = thumbImage
        addSubview(lowerThumbImageView)
        upperThumbImageView.image = thumbImage
        addSubview(upperThumbImageView)
    }
    
    private func updateLayout() {
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
        trackLayer.setNeedsDisplay()
        lowerThumbImageView.frame = CGRect(origin: thumbOriginForValue(lowerValue),
                                           size: thumbImage.size)
        upperThumbImageView.frame = CGRect(origin: thumbOriginForValue(upperValue),
                                           size: thumbImage.size)
    }
    
    func positionForValue(_ value: CGFloat) -> CGFloat {
        return bounds.width * value
    }
    
    private func thumbOriginForValue(_ value: CGFloat) -> CGPoint {
        let x = positionForValue(value) - thumbImage.size.width / 2.0
        return CGPoint(x: x, y: (bounds.height - thumbImage.size.height) / 2.0)
    }
}
