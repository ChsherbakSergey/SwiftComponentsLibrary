//  Created by Sergey Chsherbak on 19/04/2023.

import UIKit

final class ColorSelectorViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = ColorSelectorContentView()
    private var isSelected = false
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        title = "ColorPickerView"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
        setupTargets()
    }
    
    // MARK: - Setup
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSelectorView))
        contentView.selectorView.addGestureRecognizer(tapGesture)
    }
    
    private func setupTargets() {
        contentView.baseBackgroundColorSegmentedControl.addTarget(self, action: #selector(baseBackgroundColorDidChange(_:)), for: .valueChanged)
        contentView.baseStrokeForegroundColorSegmentedControl.addTarget(self, action: #selector(baseStrokeForegroundColorDidChange(_:)), for: .valueChanged)
        contentView.strokeWidthSlider.addTarget(self, action: #selector(strokeWidthSliderValueDidChange(_:)), for: .valueChanged)
        contentView.animationDurationSlider.addTarget(self, action: #selector(animationDurationSliderValueDidChange(_:)), for: .valueChanged)
        contentView.selectButton.addTarget(self, action: #selector(didTapSelectButton), for: .touchUpInside)
        contentView.deselectButton.addTarget(self, action: #selector(didTapDeselectButton), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func didTapSelectorView() {
        if isSelected {
            contentView.selectorView.deselect()
            isSelected = false
        } else {
            contentView.selectorView.select()
            isSelected = true
        }
    }
    
    @objc private func baseBackgroundColorDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            contentView.selectorView.baseBackgroundColor = .systemBlue
        } else if sender.selectedSegmentIndex == 1 {
            contentView.selectorView.baseBackgroundColor = .systemGreen
        } else {
            contentView.selectorView.baseBackgroundColor = .systemIndigo
        }
    }
    
    @objc private func baseStrokeForegroundColorDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            contentView.selectorView.baseStrokeForegroundColor = .tertiarySystemBackground
        } else if sender.selectedSegmentIndex == 1 {
            contentView.selectorView.baseStrokeForegroundColor = .white
        } else {
            contentView.selectorView.baseStrokeForegroundColor = .black
        }
    }
    
    @objc private func strokeWidthSliderValueDidChange(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        let roundedValue = round(value * 10) / 10.0

        contentView.strokeWidthLabel.text = "Stroke Width: \(roundedValue)"
        contentView.selectorView.strokeWidth = roundedValue
    }
    
    @objc private func animationDurationSliderValueDidChange(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        let roundedValue = round(value * 100) / 100.0

        contentView.animationDurationLabel.text = "Animation Duration: \(roundedValue)"
        contentView.selectorView.animationDuration = roundedValue
    }
    
    @objc private func didTapSelectButton() {
        contentView.selectorView.select()
        isSelected = true
    }
    
    @objc private func didTapDeselectButton() {
        contentView.selectorView.deselect()
        isSelected = false
    }
}
