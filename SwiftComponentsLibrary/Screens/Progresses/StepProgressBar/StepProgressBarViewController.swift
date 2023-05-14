//  Created by Sergey Chsherbak on 21/04/2023.

import UIKit

final class StepProgressBarViewController: UIViewController {
    
    // MARK: - Properties

    private let contentView = StepProgressBarContentView()

    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "StepProgressBarView"
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
        contentView.trackTintColorSegmentedControl.addTarget(self, action: #selector(trackTintColorDidChange(_:)), for: .valueChanged)
        contentView.progressTintColorSegmentedControl.addTarget(self, action: #selector(progressTintColorDidChange(_:)), for: .valueChanged)
        contentView.cornerRadiusSlider.addTarget(self, action: #selector(cornerRadiusSliderValueDidChange(_:)), for: .valueChanged)
        contentView.spacingSlider.addTarget(self, action: #selector(spacingSliderValueDidChange(_:)), for: .valueChanged)
        contentView.nextStepButton.addTarget(self, action: #selector(didTapNextStepButton), for: .touchUpInside)
        contentView.previousStepButton.addTarget(self, action: #selector(didTapPreviousStepButton), for: .touchUpInside)
    }

    // MARK: - Actions
    
    @objc private func trackTintColorDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            contentView.progressView.trackTintColor = .systemBlue.withAlphaComponent(0.25)
        } else if sender.selectedSegmentIndex == 1 {
            contentView.progressView.trackTintColor = .systemGreen.withAlphaComponent(0.25)
        } else {
            contentView.progressView.trackTintColor = .systemIndigo.withAlphaComponent(0.25)
        }
    }

    @objc private func progressTintColorDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            contentView.progressView.progressTintColor = .systemBlue
        } else if sender.selectedSegmentIndex == 1 {
            contentView.progressView.progressTintColor = .systemGreen
        } else {
            contentView.progressView.progressTintColor = .systemIndigo
        }
    }

    @objc private func cornerRadiusSliderValueDidChange(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        let roundedValue = round(value * 10) / 10.0

        contentView.cornerRadiusLabel.text = "Corner Radius: \(roundedValue)"
        contentView.progressView.cornerRadius = roundedValue
    }
    
    @objc private func spacingSliderValueDidChange(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        let roundedValue = round(value * 10) / 10.0

        contentView.spacingLabel.text = "Spacing: \(roundedValue)"
        contentView.progressView.spacing = roundedValue
    }

    @objc private func didTapNextStepButton() {
        contentView.progressView.next()
    }
    
    @objc private func didTapPreviousStepButton() {
        contentView.progressView.previous()
    }
}
