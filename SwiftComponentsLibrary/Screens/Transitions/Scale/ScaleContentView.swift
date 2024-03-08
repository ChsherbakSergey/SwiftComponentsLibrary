//  Created by Sergey Chsherbak on 19/02/2024.

import UIKit

final class ScaleContentView: UIView {
    
    // MARK: - UI Elements
    
    let cardView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.backgroundColor = .systemYellow
        return this
    }()
    
    let titleLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Scale Transition"
        this.textColor = .label
        this.font = .systemFont(ofSize: 25, weight: .bold)
        return this
    }()
    
    let subtitleLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = """
        The scale transition, as seen in iOS apps like Photos, is crucial for creating smooth, visually seamless transitions between views or view controllers. It focuses users' attention on expanded content, enhancing engagement and understanding. This transition provides intuitive navigation cues, making it easier for users to explore and interact with the app. Its consistent use establishes familiarity and contributes to a delightful user experience, reflecting the app's attention to detail and design aesthetics.
        """
        this.textColor = .label
        this.font = .systemFont(ofSize: 17, weight: .regular)
        this.numberOfLines = 0
        return this
    }()
    
    let closeButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        this.setTitle("Close", for: .normal)
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
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(closeButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 400),
            
            titleLabel.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            closeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
