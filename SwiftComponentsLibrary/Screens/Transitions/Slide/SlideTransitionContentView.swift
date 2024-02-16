//  Created by Sergey Chsherbak on 13/02/2024.

import UIKit

final class SlideTransitionContentView: UIView {
    
    // MARK: - UI Elements
    
    private let directionLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Direction:"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()
    
    let directionSegmentedControl: UISegmentedControl = {
        let this = UISegmentedControl()
        this.insertSegment(withTitle: "Left", at: 0, animated: false)
        this.insertSegment(withTitle: "Top", at: 1, animated: false)
        this.insertSegment(withTitle: "Bottom", at: 2, animated: false)
        this.insertSegment(withTitle: "Right", at: 3, animated: false)
        this.selectedSegmentIndex = 3
        return this
    }()
    
    private let directionStackView: UIStackView = {
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
    
    let button: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        this.setTitle("Present", for: .normal)
        this.backgroundColor = .systemBlue
        this.layer.cornerCurve = .continuous
        this.layer.cornerRadius = 12
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
        directionStackView.addArrangedSubview(directionLabel)
        directionStackView.addArrangedSubview(directionSegmentedControl)
        verticalStackView.addArrangedSubview(directionStackView)
        addSubview(verticalStackView)
        addSubview(button)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
