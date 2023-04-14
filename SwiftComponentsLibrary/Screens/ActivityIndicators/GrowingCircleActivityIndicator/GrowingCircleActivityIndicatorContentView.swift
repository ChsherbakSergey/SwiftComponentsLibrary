//  Created by Sergey Chsherbak on 14/04/2023.

import Components
import UIKit

final class GrowingCircleActivityIndicatorContentView: UIView {

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

    let activityIndicatorView: GrowingCircleActivityIndicatorView = {
        let this = GrowingCircleActivityIndicatorView()
        this.translatesAutoresizingMaskIntoConstraints = false
        return this
    }()

    let colorLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Color:"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let colorSegmentedControl: UISegmentedControl = {
        let this = UISegmentedControl()
        this.insertSegment(withTitle: "System Blue", at: 0, animated: false)
        this.insertSegment(withTitle: "System Green", at: 1, animated: false)
        this.insertSegment(withTitle: "System Indigo", at: 2, animated: false)
        this.selectedSegmentIndex = 0
        return this
    }()

    private let colorStackView: UIStackView = {
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
        this.insertSegment(withTitle: "Butt", at: 1, animated: false)
        this.insertSegment(withTitle: "Square", at: 2, animated: false)
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
        this.text = "Width: 2.0"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let widthSlider: UISlider = {
        let this = UISlider()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.minimumValue = 1.0
        this.maximumValue = 10.0
        this.value = 2.0
        return this
    }()

    private let widthStackView: UIStackView = {
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

    let startAnimatingButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        this.setTitle("Start Animating", for: .normal)
        this.backgroundColor = .systemBlue
        this.layer.cornerCurve = .continuous
        this.layer.cornerRadius = 12
        return this
    }()

    let stopAnimatingButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        this.setTitle("Stop Animating", for: .normal)
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
        colorStackView.addArrangedSubview(colorLabel)
        colorStackView.addArrangedSubview(colorSegmentedControl)
        lineCapStackView.addArrangedSubview(lineCapLabel)
        lineCapStackView.addArrangedSubview(lineCapSegmentedControl)
        widthStackView.addArrangedSubview(widthLabel)
        widthStackView.addArrangedSubview(widthSlider)
        animationDurationStackView.addArrangedSubview(animationDurationLabel)
        animationDurationStackView.addArrangedSubview(animationDurationSlider)
        buttonsStackView.addArrangedSubview(startAnimatingButton)
        buttonsStackView.addArrangedSubview(stopAnimatingButton)
        verticalStackView.addArrangedSubview(colorStackView)
        verticalStackView.addArrangedSubview(lineCapStackView)
        verticalStackView.addArrangedSubview(widthStackView)
        verticalStackView.addArrangedSubview(animationDurationStackView)
        verticalStackView.addArrangedSubview(buttonsStackView)
        containerView.addSubview(activityIndicatorView)
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

            activityIndicatorView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            activityIndicatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicatorView.widthAnchor.constraint(equalToConstant: 100),
            activityIndicatorView.heightAnchor.constraint(equalToConstant: 100),

            verticalStackView.topAnchor.constraint(equalTo: activityIndicatorView.bottomAnchor, constant: 32),
            verticalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),

            startAnimatingButton.heightAnchor.constraint(equalToConstant: 48),
            stopAnimatingButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
