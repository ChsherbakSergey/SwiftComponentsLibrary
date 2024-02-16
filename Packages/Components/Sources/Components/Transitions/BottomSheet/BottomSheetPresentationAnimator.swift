//  Created by Sergey Chsherbak on 14/02/2024.

import UIKit

final class BottomSheetPresentationAnimator: NSObject {}

// MARK: - UIViewControllerAnimatedTransitioning

extension BottomSheetPresentationAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.44
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(toView)
        
        let initialFrame = CGRect(
            x: toView.frame.origin.x,
            y: transitionContext.containerView.frame.size.height,
            width: toView.frame.width,
            height: toView.frame.height
        )
        let finalFrame = toView.frame
        let animationDuration = transitionDuration(using: transitionContext)
        
        toView.frame = initialFrame
        
        let animator = UIViewPropertyAnimator(duration: animationDuration, dampingRatio: 0.95) {
            toView.frame = finalFrame
        }
        animator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        animator.startAnimation()
    }
}
