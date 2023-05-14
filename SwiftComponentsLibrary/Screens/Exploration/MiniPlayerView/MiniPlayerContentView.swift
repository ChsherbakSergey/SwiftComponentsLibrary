//  Created by Sergey Chsherbak on 06/05/2023.

import Components
import UIKit

final class MiniPlayerContentView: UIView {
    
    // MARK: - UI Elements
    
    let stateLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = .systemFont(ofSize: 17, weight: .medium)
        this.textAlignment = .center
        this.textColor = .label
        this.text = "Music is paused"
        return this
    }()
    
    let playerView: MiniPlayerView = {
        let this = MiniPlayerView()
        this.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(stateLabel)
        addSubview(playerView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            stateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            stateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            playerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            playerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
