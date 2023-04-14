//  Created by Sergey Chsherbak on 14/04/2023.

import UIKit

final class ToastContentView: UIView {
    
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
    
    private let autohidesLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Autohides:"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()
    
    let autohidesSegmentedControl: UISegmentedControl = {
        let this = UISegmentedControl()
        this.insertSegment(withTitle: "Yes", at: 0, animated: false)
        this.insertSegment(withTitle: "No", at: 1, animated: false)
        this.selectedSegmentIndex = 0
        return this
    }()
    
    private let autohidesStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()
    
    let displayDurationLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Display duration: 4.0"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let displayDurationSlider: UISlider = {
        let this = UISlider()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.minimumValue = 1.0
        this.maximumValue = 10.0
        this.value = 4.0
        return this
    }()

    private let displayDurationStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()
    
    let animationDurationLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Animation duration: 0.2"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let animationDurationSlider: UISlider = {
        let this = UISlider()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.minimumValue = 0.23
        this.maximumValue = 2.5
        this.value = 0.23
        return this
    }()

    private let animationDurationStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()
    
    private let isUserInteractionEnabledLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "User Interaction Enabled:"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()
    
    let isUserInteractionEnabledSegmentedControl: UISegmentedControl = {
        let this = UISegmentedControl()
        this.insertSegment(withTitle: "Yes", at: 0, animated: false)
        this.insertSegment(withTitle: "No", at: 1, animated: false)
        this.selectedSegmentIndex = 0
        return this
    }()
    
    private let isUserInteractionEnabledStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()
    
    let errorButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        this.setTitle("Trigger Error", for: .normal)
        this.backgroundColor = .systemRed
        this.layer.cornerCurve = .continuous
        this.layer.cornerRadius = 12
        return this
    }()
    
    let warningButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        this.setTitle("Trigger Warning", for: .normal)
        this.backgroundColor = .systemYellow
        this.layer.cornerCurve = .continuous
        this.layer.cornerRadius = 12
        return this
    }()
    
    let successButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        this.setTitle("Trigger Success", for: .normal)
        this.backgroundColor = .systemGreen
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
        autohidesStackView.addArrangedSubview(autohidesLabel)
        autohidesStackView.addArrangedSubview(autohidesSegmentedControl)
        displayDurationStackView.addArrangedSubview(displayDurationLabel)
        displayDurationStackView.addArrangedSubview(displayDurationSlider)
        animationDurationStackView.addArrangedSubview(animationDurationLabel)
        animationDurationStackView.addArrangedSubview(animationDurationSlider)
        isUserInteractionEnabledStackView.addArrangedSubview(isUserInteractionEnabledLabel)
        isUserInteractionEnabledStackView.addArrangedSubview(isUserInteractionEnabledSegmentedControl)
        buttonsStackView.addArrangedSubview(errorButton)
        buttonsStackView.addArrangedSubview(warningButton)
        buttonsStackView.addArrangedSubview(successButton)
        verticalStackView.addArrangedSubview(autohidesStackView)
        verticalStackView.addArrangedSubview(displayDurationStackView)
        verticalStackView.addArrangedSubview(animationDurationStackView)
        verticalStackView.addArrangedSubview(isUserInteractionEnabledStackView)
        verticalStackView.addArrangedSubview(buttonsStackView)
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

            verticalStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            verticalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),

            errorButton.heightAnchor.constraint(equalToConstant: 48),
            warningButton.heightAnchor.constraint(equalToConstant: 48),
            successButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
