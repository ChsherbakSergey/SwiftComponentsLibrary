//  Created by Sergey Chsherbak on 17/02/2024.

import Components
import UIKit

final class ScaleTransitionViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = ScaleTransitionContentView()
    
    private var transition: ScaleTransition?
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Scale Transition"
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
        setupGestures()
    }
    
    // MARK: - Setup
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupTargets() {
        contentView.presentButton.addTarget(self, action: #selector(didTapPresentButton), for: .touchUpInside)
        contentView.pushButton.addTarget(self, action: #selector(didTapPushButton), for: .touchUpInside)
    }
    
    private func setupGestures() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCardView(_:)))
        contentView.cardView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - Actions
    
    @objc private func didTapPresentButton() {
        let viewController = ScaleViewController()
        transition = ScaleTransition()
        transition?.presentationFromDelegate = self
        transition?.presentationToDelegate = viewController
        transition?.dismissalFromDelegate = viewController
        transition?.dismissalToDelegate = self
        
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = transition
        present(viewController, animated: true)
    }
    
    @objc private func didTapPushButton() {
        let viewController = ScaleViewController()
        transition = ScaleTransition()
        transition?.pushFromDelegate = self
        transition?.pushToDelegate = viewController
        transition?.popFromDelegate = viewController
        transition?.popToDelegate = self
        
        viewController.transition = transition
        viewController.modalPresentationStyle = .custom
        navigationController?.delegate = transition
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func didTapCardView(_ gestureRecognizer: UITapGestureRecognizer) {
        didTapPushButton()
    }
}

// MARK: - ScalePresentationAnimatorFromDelegate

extension ScaleTransitionViewController: ScalePresentationAnimatorFromDelegate {
    func transitionWillBegin(_ scalePresentationAnimator: ScalePresentationAnimator) {
        contentView.cardView.isHidden = true
    }
    
    func transitionDidEnd(_ scalePresentationAnimator: ScalePresentationAnimator) {}
    
    func originFrameForScalingView(_ scalePresentationAnimator: ScalePresentationAnimator) -> CGRect {
        return contentView.cardView.frame
    }
}

// MARK: - ScaleDismissalAnimatorToDelegate

extension ScaleTransitionViewController: ScaleDismissalAnimatorToDelegate {
    func transitionWillBegin(_ scaleDismissalAnimator: ScaleDismissalAnimator) {}
    
    func transitionDidEnd(_ scaleDismissalAnimator: ScaleDismissalAnimator) {
        contentView.cardView.isHidden = false
        transition = nil
    }
    
    func finalFrameForScalingView(_ scaleDismissalAnimator: ScaleDismissalAnimator) -> CGRect {
        return contentView.cardView.frame
    }
}

// MARK: - ScalePushAnimatorFromDelegate

extension ScaleTransitionViewController: ScalePushAnimatorFromDelegate {
    func transitionWillBegin(_ scalePushAnimator: ScalePushAnimator) {
        contentView.cardView.isHidden = true
    }
    
    func transitionDidEnd(_ scalePushAnimator: ScalePushAnimator) {}
    
    func originFrameForScalingView(_ scalePushAnimator: ScalePushAnimator) -> CGRect {
        return contentView.cardView.frame
    }
}

// MARK: - ScalePopAnimatorToDelegate

extension ScaleTransitionViewController: ScalePopAnimatorToDelegate {
    func transitionWillBegin(_ scalePopAnimator: ScalePopAnimator) {}
    
    func transitionDidEnd(_ scalePopAnimator: ScalePopAnimator) {
        contentView.cardView.isHidden = false
        transition = nil
        navigationController?.delegate = nil
    }
    
    func finalFrameForScalingView(_ scalePopAnimator: ScalePopAnimator) -> CGRect {
        return contentView.cardView.frame
    }
}
