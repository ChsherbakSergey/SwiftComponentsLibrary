//  Created by Sergey Chsherbak on 18/04/2023.

import UIKit

final class FlowPageControlContentView: UIView {
    
    // MARK: - UI Elements
    
    private let squareView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.layer.cornerCurve = .continuous
        this.layer.cornerRadius = 20
        this.backgroundColor = .systemBlue
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
        addSubview(squareView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            squareView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            squareView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
            squareView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            squareView.heightAnchor.constraint(equalTo: squareView.widthAnchor)
        ])
    }
}
