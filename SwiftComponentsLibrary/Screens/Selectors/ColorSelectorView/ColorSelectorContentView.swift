//  Created by Sergey Chsherbak on 19/04/2023.

import Components
import UIKit

final class ColorSelectorContentView: UIView {
    
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
    
    let selectorView: ColorSelectorView = {
        let this = ColorSelectorView()
        this.translatesAutoresizingMaskIntoConstraints = false
        return this
    }()
    
    let baseBackgroundColorLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Background Color:"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let baseBackgroundColorSegmentedControl: UISegmentedControl = {
        let this = UISegmentedControl()
        this.insertSegment(withTitle: "System Blue", at: 0, animated: false)
        this.insertSegment(withTitle: "System Green", at: 1, animated: false)
        this.insertSegment(withTitle: "System Indigo", at: 2, animated: false)
        this.selectedSegmentIndex = 0
        return this
    }()

    private let baseBackgroundColorStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()
    
    let baseStrokeForegroundColorLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Stroke Foreground Color:"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let baseStrokeForegroundColorSegmentedControl: UISegmentedControl = {
        let this = UISegmentedControl()
        this.insertSegment(withTitle: "Tertiary", at: 0, animated: false)
        this.insertSegment(withTitle: "White", at: 1, animated: false)
        this.insertSegment(withTitle: "Black", at: 2, animated: false)
        this.selectedSegmentIndex = 0
        return this
    }()

    private let baseStrokeForegroundColorStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()
    
    let strokeWidthLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Stroke Width: 2"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let strokeWidthSlider: UISlider = {
        let this = UISlider()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.minimumValue = 2
        this.maximumValue = 5
        this.value = 2
        return this
    }()

    private let strokeWidthStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()
    
    let animationDurationLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Animation duration: 0.23"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let animationDurationSlider: UISlider = {
        let this = UISlider()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.minimumValue = 0.23
        this.maximumValue = 0.5
        this.value = 0.23
        return this
    }()

    private let animationDurationStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()
    
    let selectButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        this.setTitle("Select", for: .normal)
        this.backgroundColor = .systemBlue
        this.layer.cornerCurve = .continuous
        this.layer.cornerRadius = 12
        return this
    }()
    
    let deselectButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        this.setTitle("Deselect", for: .normal)
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
        baseBackgroundColorStackView.addArrangedSubview(baseBackgroundColorLabel)
        baseBackgroundColorStackView.addArrangedSubview(baseBackgroundColorSegmentedControl)
        baseStrokeForegroundColorStackView.addArrangedSubview(baseStrokeForegroundColorLabel)
        baseStrokeForegroundColorStackView.addArrangedSubview(baseStrokeForegroundColorSegmentedControl)
        strokeWidthStackView.addArrangedSubview(strokeWidthLabel)
        strokeWidthStackView.addArrangedSubview(strokeWidthSlider)
        animationDurationStackView.addArrangedSubview(animationDurationLabel)
        animationDurationStackView.addArrangedSubview(animationDurationSlider)
        buttonsStackView.addArrangedSubview(selectButton)
        buttonsStackView.addArrangedSubview(deselectButton)
        verticalStackView.addArrangedSubview(baseBackgroundColorStackView)
        verticalStackView.addArrangedSubview(baseStrokeForegroundColorStackView)
        verticalStackView.addArrangedSubview(strokeWidthStackView)
        verticalStackView.addArrangedSubview(animationDurationStackView)
        verticalStackView.addArrangedSubview(buttonsStackView)
        containerView.addSubview(selectorView)
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

            selectorView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            selectorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            selectorView.widthAnchor.constraint(equalToConstant: 48),
            selectorView.heightAnchor.constraint(equalToConstant: 48),

            verticalStackView.topAnchor.constraint(equalTo: selectorView.bottomAnchor, constant: 32),
            verticalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),

            selectButton.heightAnchor.constraint(equalToConstant: 48),
            deselectButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
