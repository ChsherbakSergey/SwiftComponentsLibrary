//  Created by Sergey Chsherbak on 18/04/2023.

import Components
import UIKit

final class CarouselPickerContentView: UIView {
    
    // MARK: - UI Element
    
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
    
    let pickerView: CarouselPickerView = {
        let this = CarouselPickerView(numberOfBars: 11)
        this.translatesAutoresizingMaskIntoConstraints = false
        return this
    }()
    
    let baseSelectedForegroundColorLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Selected Color:"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let baseSelectedForegroundColorSegmentedControl: UISegmentedControl = {
        let this = UISegmentedControl()
        this.insertSegment(withTitle: "System Blue", at: 0, animated: false)
        this.insertSegment(withTitle: "System Green", at: 1, animated: false)
        this.insertSegment(withTitle: "System Indigo", at: 2, animated: false)
        this.selectedSegmentIndex = 0
        return this
    }()

    private let baseSelectedForegroundColorStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()
    
    let baseUnselectedForegroundColorLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Unselected Color:"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let baseUnselectedForegroundColorSegmentedControl: UISegmentedControl = {
        let this = UISegmentedControl()
        this.insertSegment(withTitle: "System Gray", at: 0, animated: false)
        this.insertSegment(withTitle: "System Pink", at: 1, animated: false)
        this.insertSegment(withTitle: "System Purple", at: 2, animated: false)
        this.selectedSegmentIndex = 0
        return this
    }()

    private let baseUnselectedForegroundColorStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()
    
    let spacingLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Spacing: 40"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let spacingSlider: UISlider = {
        let this = UISlider()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.minimumValue = 20
        this.maximumValue = 60
        this.value = 40
        return this
    }()

    private let spacingStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()
    
    let alphaLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Alpha: 0.5"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let alphaSlider: UISlider = {
        let this = UISlider()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.minimumValue = 0.25
        this.maximumValue = 0.75
        this.value = 0.5
        return this
    }()

    private let alphaStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()
    
    let scaleLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Scale: 0.65"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let scaleSlider: UISlider = {
        let this = UISlider()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.minimumValue = 0.4
        this.maximumValue = 0.8
        this.value = 0.65
        return this
    }()

    private let scaleStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()
    
    let setRandomValueButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        this.setTitle("Set Random Value", for: .normal)
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
        baseSelectedForegroundColorStackView.addArrangedSubview(baseSelectedForegroundColorLabel)
        baseSelectedForegroundColorStackView.addArrangedSubview(baseSelectedForegroundColorSegmentedControl)
        baseUnselectedForegroundColorStackView.addArrangedSubview(baseUnselectedForegroundColorLabel)
        baseUnselectedForegroundColorStackView.addArrangedSubview(baseUnselectedForegroundColorSegmentedControl)
        spacingStackView.addArrangedSubview(spacingLabel)
        spacingStackView.addArrangedSubview(spacingSlider)
        alphaStackView.addArrangedSubview(alphaLabel)
        alphaStackView.addArrangedSubview(alphaSlider)
        scaleStackView.addArrangedSubview(scaleLabel)
        scaleStackView.addArrangedSubview(scaleSlider)
        buttonsStackView.addArrangedSubview(setRandomValueButton)
        verticalStackView.addArrangedSubview(baseSelectedForegroundColorStackView)
        verticalStackView.addArrangedSubview(baseUnselectedForegroundColorStackView)
        verticalStackView.addArrangedSubview(spacingStackView)
        verticalStackView.addArrangedSubview(alphaStackView)
        verticalStackView.addArrangedSubview(scaleStackView)
        verticalStackView.addArrangedSubview(buttonsStackView)
        containerView.addSubview(pickerView)
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

            pickerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            pickerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),

            verticalStackView.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 32),
            verticalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),

            setRandomValueButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
