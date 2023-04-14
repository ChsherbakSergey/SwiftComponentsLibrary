//  Created by Sergey Chsherbak on 14/04/2023.

import Components
import UIKit

final class ToastViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = ToastContentView()
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "ToastView"
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
        setupTargets()
    }
    
    // MARK: - Setup

    private func setupTargets() {
        contentView.autohidesSegmentedControl.addTarget(self, action: #selector(autohidesDidChange(_:)), for: .valueChanged)
        contentView.displayDurationSlider.addTarget(self, action: #selector(displayDurationSliderValueDidChange(_:)), for: .valueChanged)
        contentView.animationDurationSlider.addTarget(self, action: #selector(animationDurationSliderValueDidChange(_:)), for: .valueChanged)
        contentView.isUserInteractionEnabledSegmentedControl.addTarget(self, action: #selector(isUserInteractionEnabledDidChange(_:)), for: .valueChanged)
        contentView.errorButton.addTarget(self, action: #selector(didTapErrorButton), for: .touchUpInside)
        contentView.warningButton.addTarget(self, action: #selector(didTapWarningButton), for: .touchUpInside)
        contentView.successButton.addTarget(self, action: #selector(didTapSuccessButton), for: .touchUpInside)
    }

    // MARK: - Actions
    
    @objc private func autohidesDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex != 0 {
            if contentView.isUserInteractionEnabledSegmentedControl.selectedSegmentIndex != 0 {
                contentView.isUserInteractionEnabledSegmentedControl.selectedSegmentIndex = 0
            }
        }
    }
    
    @objc private func displayDurationSliderValueDidChange(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        let roundedValue = round(value * 10) / 10.0

        contentView.displayDurationLabel.text = "Display Duration: \(roundedValue)"
    }
    
    @objc private func animationDurationSliderValueDidChange(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        let roundedValue = round(value * 10) / 10.0

        contentView.animationDurationLabel.text = "Animation Duration: \(roundedValue)"
    }
    
    @objc private func isUserInteractionEnabledDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex != 0 {
            if contentView.autohidesSegmentedControl.selectedSegmentIndex != 0 {
                contentView.autohidesSegmentedControl.selectedSegmentIndex = 0
            }
        }
    }
    
    @objc private func didTapErrorButton() {
        let isAutohidable = contentView.autohidesSegmentedControl.selectedSegmentIndex == 0 ? true : false
        let displayDuration = TimeInterval(contentView.displayDurationSlider.value)
        let animationDuration = TimeInterval(contentView.animationDurationSlider.value)
        let isUserInteractionEnabled = contentView.isUserInteractionEnabledSegmentedControl.selectedSegmentIndex == 0 ? true : false
        let configuration = ToastConfiguration(
            isAutohidable: isAutohidable,
            displayDuration: displayDuration,
            animationDuration: animationDuration,
            isUserInteractionEnabled: isUserInteractionEnabled,
            animationType: .top
        )
        let model = ToastView.Model(
            type: .error,
            title: "Error",
            subtitle: "You need to star this project."
        )
        Toaster.shared.show(with: configuration, model: model)
    }
    
    @objc private func didTapWarningButton() {
        let isAutohidable = contentView.autohidesSegmentedControl.selectedSegmentIndex == 0 ? true : false
        let displayDuration = TimeInterval(contentView.displayDurationSlider.value)
        let animationDuration = TimeInterval(contentView.animationDurationSlider.value)
        let isUserInteractionEnabled = contentView.isUserInteractionEnabledSegmentedControl.selectedSegmentIndex == 0 ? true : false
        let configuration = ToastConfiguration(
            isAutohidable: isAutohidable,
            displayDuration: displayDuration,
            animationDuration: animationDuration,
            isUserInteractionEnabled: isUserInteractionEnabled,
            animationType: .top
        )
        let model = ToastView.Model(
            type: .warning,
            title: "Warning",
            subtitle: "Have you considered to star this project?"
        )
        Toaster.shared.show(with: configuration, model: model)
    }
    
    @objc private func didTapSuccessButton() {
        let isAutohidable = contentView.autohidesSegmentedControl.selectedSegmentIndex == 0 ? true : false
        let displayDuration = TimeInterval(contentView.displayDurationSlider.value)
        let animationDuration = TimeInterval(contentView.animationDurationSlider.value)
        let isUserInteractionEnabled = contentView.isUserInteractionEnabledSegmentedControl.selectedSegmentIndex == 0 ? true : false
        let configuration = ToastConfiguration(
            isAutohidable: isAutohidable,
            displayDuration: displayDuration,
            animationDuration: animationDuration,
            isUserInteractionEnabled: isUserInteractionEnabled,
            animationType: .top
        )
        let model = ToastView.Model(
            type: .success,
            title: "Success",
            subtitle: "Way to go. This project deserves another star!"
        )
        Toaster.shared.show(with: configuration, model: model)
    }
}
