//  Created by Sergey Chsherbak on 17/02/2024.

import UIKit

public final class ScaleTransition: NSObject {
    
    // MARK: - Properties
    
    public weak var presentationFromDelegate: ScalePresentationAnimatorFromDelegate?
    public weak var presentationToDelegate: ScalePresentationAnimatorToDelegate?
    public weak var dismissalFromDelegate: ScaleDismissalAnimatorFromDelegate?
    public weak var dismissalToDelegate: ScaleDismissalAnimatorToDelegate?
    public weak var pushFromDelegate: ScalePushAnimatorFromDelegate?
    public weak var pushToDelegate: ScalePushAnimatorToDelegate?
    public weak var popFromDelegate: ScalePopAnimatorFromDelegate?
    public weak var popToDelegate: ScalePopAnimatorToDelegate?
    
    public var interactionController: UIPercentDrivenInteractiveTransition?
}

// MARK: - UIViewControllerTransitioningDelegate

extension ScaleTransition: UIViewControllerTransitioningDelegate {
    public func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        let presentationController = ScalePresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
        presentationController.wantsInteractiveDismissal = true
        return presentationController
    }
    
    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        let animator = ScalePresentationAnimator()
        animator.fromDelegate = presentationFromDelegate
        animator.toDelegate = presentationToDelegate
        return animator
    }
    
    public func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        let animator = ScaleDismissalAnimator()
        animator.fromDelegate = dismissalFromDelegate
        animator.toDelegate = dismissalToDelegate
        return animator
    }
}

// MARK: - UINavigationControllerDelegate

extension ScaleTransition: UINavigationControllerDelegate {
    public func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .none:
            return nil
        case .push:
            let animator = ScalePushAnimator()
            animator.fromDelegate = pushFromDelegate
            animator.toDelegate = pushToDelegate
            return animator
        case .pop:
            let animator = ScalePopAnimator()
            animator.fromDelegate = popFromDelegate
            animator.toDelegate = popToDelegate
            return animator
        @unknown default:
            fatalError("Unknown case in the `UINavigationController.Operation` enum.")
        }
    }
    
    public func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
}
