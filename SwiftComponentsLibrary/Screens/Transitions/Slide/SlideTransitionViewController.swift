//  Created by Sergey Chsherbak on 13/02/2024.

import Components
import UIKit

final class SlideTransitionViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = SlideTransitionContentView()
    private var transition = SlideTransition()
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Slide Transition"
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
        contentView.directionSegmentedControl.addTarget(self, action: #selector(directionDidChange(_:)), for: .valueChanged)
        contentView.button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func directionDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            transition.direction = .left
        } else if sender.selectedSegmentIndex == 1 {
            transition.direction = .top
        } else if sender.selectedSegmentIndex == 2 {
            transition.direction = .bottom
        } else {
            transition.direction = .right
        }
    }
    
    @objc private func didTapButton() {
        let viewController = SlideViewController()
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = transition
        present(viewController, animated: true)
    }
}
