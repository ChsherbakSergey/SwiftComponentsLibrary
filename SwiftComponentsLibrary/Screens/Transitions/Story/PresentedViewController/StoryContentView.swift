//  Created by Sergey Chsherbak on 21/02/2024.

import UIKit

final class StoryContentView: UIView {
    
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
        backgroundColor = .systemRed
    }
    
    private func setupSubviews() {}
    
    private func setupLayout() {}
}
