//  Created by Sergey Chsherbak on 14/04/2023.

import Components
import UIKit

final class GrowingCircleActivityIndicatorViewController: UIViewController {

    // MARK: - Properties

    private let contentView = GrowingCircleActivityIndicatorContentView()

    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "GrowingCircleActivityIndicatorView"
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
        setupActivityIndicator()
        setupTargets()
    }

    // MARK: - Setup
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupActivityIndicator() {
        contentView.activityIndicatorView.startAnimating()
    }

    private func setupTargets() {
        contentView.colorSegmentedControl.addTarget(self, action: #selector(colorDidChange(_:)), for: .valueChanged)
        contentView.lineCapSegmentedControl.addTarget(self, action: #selector(lineCapDidChange(_:)), for: .valueChanged)
        contentView.widthSlider.addTarget(self, action: #selector(widthSliderValueDidChange(_:)), for: .valueChanged)
        contentView.animationDurationSlider.addTarget(self, action: #selector(animationDurationSliderValueDidChange(_:)), for: .valueChanged)
        contentView.startAnimatingButton.addTarget(self, action: #selector(didTapStartAnimatingButton), for: .touchUpInside)
        contentView.stopAnimatingButton.addTarget(self, action: #selector(didTapStopAnimatingButton), for: .touchUpInside)
    }

    // MARK: - Acitons

    @objc private func colorDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            contentView.activityIndicatorView.color = .systemBlue
        } else if sender.selectedSegmentIndex == 1 {
            contentView.activityIndicatorView.color = .systemGreen
        } else {
            contentView.activityIndicatorView.color = .systemIndigo
        }
    }

    @objc private func lineCapDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            contentView.activityIndicatorView.lineCap = .round
        } else if sender.selectedSegmentIndex == 1 {
            contentView.activityIndicatorView.lineCap = .butt
        } else {
            contentView.activityIndicatorView.lineCap = .square
        }
    }

    @objc private func widthSliderValueDidChange(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        let roundedValue = round(value * 10) / 10.0

        contentView.widthLabel.text = "Width: \(roundedValue)"
        contentView.activityIndicatorView.width = roundedValue
    }

    @objc private func animationDurationSliderValueDidChange(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        let roundedValue = round(value * 10) / 10.0

        contentView.animationDurationLabel.text = "Animation Duration: \(roundedValue)"
        contentView.activityIndicatorView.animationDuration = roundedValue
    }

    @objc private func didTapStartAnimatingButton() {
        contentView.activityIndicatorView.startAnimating()
    }

    @objc private func didTapStopAnimatingButton() {
        contentView.activityIndicatorView.stopAnimating()
    }
}
