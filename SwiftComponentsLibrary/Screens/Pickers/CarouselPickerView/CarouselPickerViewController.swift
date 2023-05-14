//  Created by Sergey Chsherbak on 18/04/2023.

import UIKit

final class CarouselPickerViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = CarouselPickerContentView()
    private let randomValues = [-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        title = "CarouselPickerView"
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
        setupNavigationBar()
        setupTargets()
    }
    
    // MARK: - Setup
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupTargets() {
        contentView.baseSelectedForegroundColorSegmentedControl.addTarget(self, action: #selector(baseSelectedForegroundColorDidChange(_:)), for: .valueChanged)
        contentView.baseUnselectedForegroundColorSegmentedControl.addTarget(self, action: #selector(baseUnselectedForegroundColorDidChange(_:)), for: .valueChanged)
        contentView.spacingSlider.addTarget(self, action: #selector(spacingSliderValueDidChange(_:)), for: .valueChanged)
        contentView.alphaSlider.addTarget(self, action: #selector(alphaSliderValueDidChange(_:)), for: .valueChanged)
        contentView.scaleSlider.addTarget(self, action: #selector(scaleSliderValueDidChange(_:)), for: .valueChanged)
        contentView.setRandomValueButton.addTarget(self, action: #selector(didTapSetRandomValueButton), for: .touchUpInside)
    }
    
    // MARK: - Actions

    @objc private func baseSelectedForegroundColorDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            contentView.pickerView.baseSelectedForegroundColor = .systemBlue
        } else if sender.selectedSegmentIndex == 1 {
            contentView.pickerView.baseSelectedForegroundColor = .systemGreen
        } else {
            contentView.pickerView.baseSelectedForegroundColor = .systemIndigo
        }
    }
    
    @objc private func baseUnselectedForegroundColorDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            contentView.pickerView.baseUnselectedForegroundColor = .systemGray4
        } else if sender.selectedSegmentIndex == 1 {
            contentView.pickerView.baseUnselectedForegroundColor = .systemPink
        } else {
            contentView.pickerView.baseUnselectedForegroundColor = .systemPurple
        }
    }
    
    @objc private func spacingSliderValueDidChange(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        let roundedValue = round(value * 10) / 10.0

        contentView.spacingLabel.text = "Spacing: \(roundedValue)"
        contentView.pickerView.spacing = roundedValue
    }
    
    @objc private func alphaSliderValueDidChange(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        let roundedValue = round(value * 100) / 100.0

        contentView.alphaLabel.text = "Alpha: \(roundedValue)"
        contentView.pickerView.standardItemAlpha = roundedValue
    }
    
    @objc private func scaleSliderValueDidChange(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        let roundedValue = round(value * 100) / 100.0

        contentView.scaleLabel.text = "Scale: \(roundedValue)"
        contentView.pickerView.standardItemScale = roundedValue
    }
    
    @objc private func didTapSetRandomValueButton() {
        contentView.pickerView.scrollToValue(randomValues.randomElement()!, animated: true)
    }
}
