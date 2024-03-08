//  Created by Sergey Chsherbak on 17/02/2024.

import UIKit

final class ScaleTransitionContentView: UIView {
    
    // MARK: - UI Elements
    
    let cardView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.backgroundColor = .systemYellow
        this.layer.cornerRadius = 20
        this.layer.cornerCurve = .continuous
        return this
    }()
    
    let presentButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        this.setTitle("Present", for: .normal)
        this.backgroundColor = .systemBlue
        this.layer.cornerCurve = .continuous
        this.layer.cornerRadius = 12
        return this
    }()
    
    let pushButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        this.setTitle("Push", for: .normal)
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
        addSubview(cardView)
        buttonsStackView.addArrangedSubview(presentButton)
        buttonsStackView.addArrangedSubview(pushButton)
        verticalStackView.addArrangedSubview(buttonsStackView)
        addSubview(verticalStackView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            cardView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            cardView.heightAnchor.constraint(equalToConstant: 200),
            
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            verticalStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            presentButton.heightAnchor.constraint(equalToConstant: 48),
            pushButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
