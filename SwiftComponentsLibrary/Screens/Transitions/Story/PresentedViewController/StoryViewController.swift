//  Created by Sergey Chsherbak on 21/02/2024.

import UIKit

final class StoryViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = StoryContentView()
    
    // MARK: - Lifeycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    // MARK: - Setup
    
    private func setupNavigationBar() {
        let closeBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapCloseButton(_:)))
        navigationItem.rightBarButtonItem = closeBarButtonItem
    }
    
    // MARK: - Actions
    
    @objc private func didTapCloseButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
