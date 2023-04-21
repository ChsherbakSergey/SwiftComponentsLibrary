//  Created by Sergey Chsherbak on 20/04/2023.

import Components
import UIKit

final class Button3DContentView: UIView {
    
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

    let button: Button3D = {
        let this = Button3D()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.title = "⭐️  Star this project +1 XP"
        this.cornerRadius = 12
        return this
    }()
    
    let styleLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Style:"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let styleSegmentedControl: UISegmentedControl = {
        let this = UISegmentedControl()
        this.insertSegment(withTitle: "Red", at: 0, animated: false)
        this.insertSegment(withTitle: "Yellow", at: 1, animated: false)
        this.insertSegment(withTitle: "Green", at: 2, animated: false)
        this.selectedSegmentIndex = 2
        return this
    }()

    private let styleStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()
    
    let cornerRadiusLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Corner Radius: 12"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()
    
    let cornerRadiusSlider: UISlider = {
        let this = UISlider()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.minimumValue = 0
        this.maximumValue = 20
        this.value = 12
        return this
    }()

    private let cornerRadiusStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
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
        styleStackView.addArrangedSubview(styleLabel)
        styleStackView.addArrangedSubview(styleSegmentedControl)
        cornerRadiusStackView.addArrangedSubview(cornerRadiusLabel)
        cornerRadiusStackView.addArrangedSubview(cornerRadiusSlider)
        verticalStackView.addArrangedSubview(styleStackView)
        verticalStackView.addArrangedSubview(cornerRadiusStackView)
        containerView.addSubview(button)
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

            button.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            button.heightAnchor.constraint(equalToConstant: 52),

            verticalStackView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 32),
            verticalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
}
