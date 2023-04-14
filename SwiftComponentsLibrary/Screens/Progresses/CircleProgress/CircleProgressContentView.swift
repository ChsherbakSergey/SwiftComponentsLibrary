//  Created by Sergey Chsherbak on 14/04/2023.

import Components
import UIKit

final class CircleProgressContentView: UIView {

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

    let progressView: CircleProgressView = {
        let this = CircleProgressView()
        this.translatesAutoresizingMaskIntoConstraints = false
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

    let lineCapLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Line Cap:"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let lineCapSegmentedControl: UISegmentedControl = {
        let this = UISegmentedControl()
        this.insertSegment(withTitle: "Round", at: 0, animated: false)
        this.insertSegment(withTitle: "Square", at: 1, animated: false)
        this.selectedSegmentIndex = 0
        return this
    }()

    private let lineCapStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()

    let widthLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Width: 20"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let widthSlider: UISlider = {
        let this = UISlider()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.minimumValue = 10
        this.maximumValue = 30
        this.value = 20
        return this
    }()

    private let widthStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()

    let progressValueLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Progress Value:"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let progressValueSegmentedControl: UISegmentedControl = {
        let this = UISegmentedControl()
        this.insertSegment(withTitle: "0.25", at: 0, animated: false)
        this.insertSegment(withTitle: "0.5", at: 1, animated: false)
        this.insertSegment(withTitle: "0.75", at: 2, animated: false)
        this.insertSegment(withTitle: "1", at: 3, animated: false)
        this.selectedSegmentIndex = 0
        return this
    }()

    private let progressValueStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()

    let isAnimationEnabledLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Animation Is Enabled:"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let isAnimationEnabledSegmentedControl: UISegmentedControl = {
        let this = UISegmentedControl()
        this.insertSegment(withTitle: "Yes", at: 0, animated: false)
        this.insertSegment(withTitle: "No", at: 1, animated: false)
        this.selectedSegmentIndex = 0
        return this
    }()

    private let isAnimationEnabledStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()

    let animationDurationLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Animation duration: 1.5"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let animationDurationSlider: UISlider = {
        let this = UISlider()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.minimumValue = 0.5
        this.maximumValue = 10.0
        this.value = 1.5
        return this
    }()

    private let animationDurationStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()

    let setProgressButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        this.setTitle("Set Progress", for: .normal)
        this.backgroundColor = .systemBlue
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
        lineCapStackView.addArrangedSubview(lineCapLabel)
        lineCapStackView.addArrangedSubview(lineCapSegmentedControl)
        widthStackView.addArrangedSubview(widthLabel)
        widthStackView.addArrangedSubview(widthSlider)
        progressValueStackView.addArrangedSubview(progressValueLabel)
        progressValueStackView.addArrangedSubview(progressValueSegmentedControl)
        isAnimationEnabledStackView.addArrangedSubview(isAnimationEnabledLabel)
        isAnimationEnabledStackView.addArrangedSubview(isAnimationEnabledSegmentedControl)
        animationDurationStackView.addArrangedSubview(animationDurationLabel)
        animationDurationStackView.addArrangedSubview(animationDurationSlider)
        buttonsStackView.addArrangedSubview(setProgressButton)
        verticalStackView.addArrangedSubview(trackTintColorStackView)
        verticalStackView.addArrangedSubview(progressTintColorStackView)
        verticalStackView.addArrangedSubview(lineCapStackView)
        verticalStackView.addArrangedSubview(widthStackView)
        verticalStackView.addArrangedSubview(progressValueStackView)
        verticalStackView.addArrangedSubview(isAnimationEnabledStackView)
        verticalStackView.addArrangedSubview(animationDurationStackView)
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
            progressView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 200),
            progressView.widthAnchor.constraint(equalToConstant: 200),

            verticalStackView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 32),
            verticalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),

            setProgressButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
