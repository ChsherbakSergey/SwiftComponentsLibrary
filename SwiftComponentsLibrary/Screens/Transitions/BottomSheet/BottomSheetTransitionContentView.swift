//  Created by Sergey Chsherbak on 08/02/2024.

import UIKit

final class BottomSheetTransitionContentView: UIView {
    
    // MARK: - UI Elements
    
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
        addSubview(button)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
