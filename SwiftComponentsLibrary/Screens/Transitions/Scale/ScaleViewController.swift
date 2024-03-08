//  Created by Sergey Chsherbak on 17/02/2024.

import Components
import UIKit

final class ScaleViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = ScaleContentView()
    
    private var interactionController = PanInteractionController()
    
    var transition: ScaleTransition?
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Scaled View"
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
        setupInteractionController()
    }
    
    // MARK: - Setup
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupTargets() {
        contentView.closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
    }
    
    private func setupInteractionController() {
        interactionController.delegate = self
        interactionController.attachTo(view: contentView)
        navigationController?.delegate = transition
    }
    
    // MARK: - Actions
    
    @objc private func didTapCloseButton() {
        if navigationController == nil {
            dismiss(animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - ScalePresentationAnimatorToDelegate

extension ScaleViewController: ScalePresentationAnimatorToDelegate {
    func transitionWillBegin(_ scalePresentationAnimator: ScalePresentationAnimator) {
        contentView.cardView.isHidden = true
    }
    
    func transitionDidEnd(_ scalePresentationAnimator: ScalePresentationAnimator) {
        contentView.cardView.isHidden = false
    }
    
    func finalFrameForScalingView(_ scalePresentationAnimator: ScalePresentationAnimator) -> CGRect {
        return CGRect(
            x: contentView.frame.origin.x,
            y: contentView.frame.origin.y,
            width: contentView.frame.width,
            height: 400
        )
    }
}

// MARK: - ScaleDismissalAnimatorFromDelegate

extension ScaleViewController: ScaleDismissalAnimatorFromDelegate {
    func transitionWillBegin(_ scaleDismissalAnimator: ScaleDismissalAnimator) {
        contentView.cardView.isHidden = true
    }
    
    func transitionDidEnd(_ scaleDismissalAnimator: ScaleDismissalAnimator) {}
    
    func originFrameForScalingView(_ scaleDismissalAnimator: ScaleDismissalAnimator) -> CGRect {
        return contentView.cardView.frame
    }
}

// MARK: - ScalePushAnimatorToDelegate

extension ScaleViewController: ScalePushAnimatorToDelegate {
    func transitionWillBegin(_ scalePushAnimator: ScalePushAnimator) {
        contentView.cardView.isHidden = true
    }
    
    func transitionDidEnd(_ scalePushAnimator: ScalePushAnimator) {
        contentView.cardView.isHidden = false
    }
    
    func finalFrameForScalingView(_ scalePushAnimator: ScalePushAnimator) -> CGRect {
        return CGRect(
            x: contentView.frame.origin.x,
            y: contentView.frame.origin.y,
            width: contentView.frame.width,
            height: 400
        )
    }
}

// MARK: - ScalePopAnimatorFromDelegate

extension ScaleViewController: ScalePopAnimatorFromDelegate {
    func transitionWillBegin(_ scalePopAnimator: ScalePopAnimator) {
        contentView.cardView.isHidden = true
    }
    
    func transitionDidEnd(_ scalePopAnimator: ScalePopAnimator) {}
    
    func originFrameForScalingView(_ scalePopAnimator: ScalePopAnimator) -> CGRect {
        return contentView.cardView.frame
    }
}

// MARK: - PanInteractionControllerDelegate

extension ScaleViewController: PanInteractionControllerDelegate {
    func interactiveAnimationDidStart(_ interactionController: Components.PanInteractionController) {
        if interactionController.isActive {
            transition?.interactionController = interactionController
        } else {
            transition?.interactionController = nil
        }
        
        navigationController?.popViewController(animated: true)
    }
}
