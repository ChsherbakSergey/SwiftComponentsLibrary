//  Created by Sergey Chsherbak on 13/02/2024.

import UIKit

final class FlipTransitionContentView: UIView {
    
    // MARK: - UI Elements
    
    let cardView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.backgroundColor = .systemBlue
        this.layer.cornerRadius = 20
        this.layer.cornerCurve = .continuous
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
        addSubview(cardView)
        addSubview(button)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            cardView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            cardView.heightAnchor.constraint(equalToConstant: 200),
            
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
