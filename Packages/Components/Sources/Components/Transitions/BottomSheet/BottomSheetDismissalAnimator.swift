//  Created by Sergey Chsherbak on 14/02/2024.

import UIKit

final class BottomSheetDismissalAnimator: NSObject {}

// MARK: - UIViewControllerAnimatedTransitioning

extension BottomSheetDismissalAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.44
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        
        let initialFrame = fromView.frame
        let finalFrame = CGRect(
            x: fromView.frame.origin.x,
            y: transitionContext.containerView.frame.size.height,
            width: fromView.frame.width,
            height: fromView.frame.height
        )
        let animationDuration = transitionDuration(using: transitionContext)
        
        fromView.frame = initialFrame
        
        let animator = UIViewPropertyAnimator(duration: animationDuration, dampingRatio: 0.95) {
            fromView.frame = finalFrame
        }
        animator.addCompletion { _ in
            fromView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        animator.startAnimation()
    }
}
