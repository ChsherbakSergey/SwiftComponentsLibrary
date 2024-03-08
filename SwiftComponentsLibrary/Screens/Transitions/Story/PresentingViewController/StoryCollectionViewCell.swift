//  Created by Sergey Chsherbak on 21/02/2024.

import UIKit

final class StoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let storyView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.layer.cornerRadius = 32
        this.isUserInteractionEnabled = false
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
    
    // MARK: - Configuration
    
    func configure(with color: UIColor) {
        storyView.backgroundColor = color
    }
    
    // MARK: - Setup
    
    private func setupView() {
        contentView.backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        contentView.addSubview(storyView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            storyView.topAnchor.constraint(equalTo: contentView.topAnchor),
            storyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            storyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            storyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
