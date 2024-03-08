//  Created by Sergey Chsherbak on 13/02/2024.

import Components
import UIKit

final class FlipTransitionViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = FlipTransitionContentView()
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Flip Transition"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTargets()
    }
    
    // MARK: - Setup
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupTargets() {
        contentView.button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func didTapButton() {
        let transition = FlipTransition(
            cardViewSnapshot: contentView.cardView.snapshotView(afterScreenUpdates: true)!,
            originFrame: contentView.cardView.frame
        )
        let viewController = FlipViewController()
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = transition
        present(viewController, animated: true)
    }
}
