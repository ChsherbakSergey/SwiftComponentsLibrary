//  Created by Sergey Chsherbak on 21/04/2023.

import Components
import UIKit

final class StepProgressBarContentView: UIView {
    
    // MARK: - UI Elements

    private let scrollView: UIScrollView = {
        let this = UIScrollView()
        this.translatesAutoresizingMaskIntoConstraints = false
        return this
    }()

    private let containerView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        return this
    }()

    let progressView: StepProgressBarView = {
        let this = StepProgressBarView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.cornerRadius = 5
        return this
    }()
    
    let trackTintColorLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Track Tint Color:"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let trackTintColorSegmentedControl: UISegmentedControl = {
        let this = UISegmentedControl()
        this.insertSegment(withTitle: "System Blue", at: 0, animated: false)
        this.insertSegment(withTitle: "System Green", at: 1, animated: false)
        this.insertSegment(withTitle: "System Indigo", at: 2, animated: false)
        this.selectedSegmentIndex = 0
        return this
    }()

    private let trackTintColorStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()

    let progressTintColorLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Progress Tint Color:"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let progressTintColorSegmentedControl: UISegmentedControl = {
        let this = UISegmentedControl()
        this.insertSegment(withTitle: "System Blue", at: 0, animated: false)
        this.insertSegment(withTitle: "System Green", at: 1, animated: false)
        this.insertSegment(withTitle: "System Indigo", at: 2, animated: false)
        this.selectedSegmentIndex = 0
        return this
    }()

    private let progressTintColorStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()
    
    let cornerRadiusLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Corner Radius: 5"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()
    
    let cornerRadiusSlider: UISlider = {
        let this = UISlider()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.minimumValue = 0
        this.maximumValue = 8
        this.value = 5
        return this
    }()

    private let cornerRadiusStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()
    
    let spacingLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Spacing: 4"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()
    
    let spacingSlider: UISlider = {
        let this = UISlider()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.minimumValue = 4
        this.maximumValue = 20
        this.value = 4
        return this
    }()

    private let spacingStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()
    
    let nextStepButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        this.setTitle("Next Step", for: .normal)
        this.backgroundColor = .systemBlue
        this.layer.cornerCurve = .continuous
        this.layer.cornerRadius = 12
        return this
    }()
    
    let previousStepButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        this.setTitle("Previous Step", for: .normal)
        this.backgroundColor = .systemRed
        this.layer.cornerCurve = .continuous
        this.layer.cornerRadius = 12
        return this
    }()

    private let buttonsStackView: UIStackView = {
        let this = UIStackView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.axis = .vertical
        this.spacing = 12
        return this
    }()

    private let verticalStackView: UIStackView = {
        let this = UIStackView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.axis = .vertical
        this.spacing = 16
        return this
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupView() {
        backgroundColor = .systemBackground
    }

    private func setupSubviews() {
        trackTintColorStackView.addArrangedSubview(trackTintColorLabel)
        trackTintColorStackView.addArrangedSubview(trackTintColorSegmentedControl)
        progressTintColorStackView.addArrangedSubview(progressTintColorLabel)
        progressTintColorStackView.addArrangedSubview(progressTintColorSegmentedControl)
        cornerRadiusStackView.addArrangedSubview(cornerRadiusLabel)
        cornerRadiusStackView.addArrangedSubview(cornerRadiusSlider)
        spacingStackView.addArrangedSubview(spacingLabel)
        spacingStackView.addArrangedSubview(spacingSlider)
        buttonsStackView.addArrangedSubview(nextStepButton)
        buttonsStackView.addArrangedSubview(previousStepButton)
        verticalStackView.addArrangedSubview(trackTintColorStackView)
        verticalStackView.addArrangedSubview(progressTintColorStackView)
        verticalStackView.addArrangedSubview(cornerRadiusStackView)
        verticalStackView.addArrangedSubview(spacingStackView)
        verticalStackView.addArrangedSubview(buttonsStackView)
        containerView.addSubview(progressView)
        containerView.addSubview(verticalStackView)
        scrollView.addSubview(containerView)
        addSubview(scrollView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            progressView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            progressView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            progressView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            progressView.heightAnchor.constraint(equalToConstant: 10),

            verticalStackView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 32),
            verticalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),

            nextStepButton.heightAnchor.constraint(equalToConstant: 48),
            previousStepButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
