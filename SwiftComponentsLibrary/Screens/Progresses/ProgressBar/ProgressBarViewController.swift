//  Created by Sergey Chsherbak on 14/04/2023.

import UIKit

final class ProgressBarViewController: UIViewController {

    // MARK: - Properties

    private let contentView = ProgressBarContentView()

    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "ProgressBarView"
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
        contentView.trackTintColorSegmentedControl.addTarget(self, action: #selector(trackTintColorDidChange(_:)), for: .valueChanged)
        contentView.progressTintColorSegmentedControl.addTarget(self, action: #selector(progressTintColorDidChange(_:)), for: .valueChanged)
        contentView.lineCapSegmentedControl.addTarget(self, action: #selector(lineCapDidChange(_:)), for: .valueChanged)
        contentView.animationDurationSlider.addTarget(self, action: #selector(animationDurationSliderValueDidChange(_:)), for: .valueChanged)
        contentView.setProgressButton.addTarget(self, action: #selector(didTapSetProgressButton), for: .touchUpInside)
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

    @objc private func lineCapDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            contentView.progressView.lineCap = .round
        } else {
            contentView.progressView.lineCap = .square
        }
    }

    @objc private func animationDurationSliderValueDidChange(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        let roundedValue = round(value * 10) / 10.0

        contentView.animationDurationLabel.text = "Animation Duration: \(roundedValue)"
        contentView.progressView.animationDuration = roundedValue
    }

    @objc private func didTapSetProgressButton() {
        let progressValue: CGFloat
        let animated: Bool

        if contentView.progressValueSegmentedControl.selectedSegmentIndex == 0 {
            progressValue = 0.25
        } else if contentView.progressValueSegmentedControl.selectedSegmentIndex == 1 {
            progressValue = 0.5
        } else if contentView.progressValueSegmentedControl.selectedSegmentIndex == 2 {
            progressValue = 0.75
        } else {
            progressValue = 1
        }

        if contentView.isAnimationEnabledSegmentedControl.selectedSegmentIndex == 0 {
            animated = true
        } else {
            animated = false
        }

        contentView.progressView.setProgress(to: progressValue, animated: animated)
    }
}
