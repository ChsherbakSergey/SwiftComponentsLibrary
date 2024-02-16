//  Created by Sergey Chsherbak on 13/02/2024.

import UIKit

final class SlideDismissalAnimator: NSObject {
    
    // MARK: - Properties
    
    private let direction: SlideTransition.PresentationDirection
    
    // MARK: - Init
    
    init(
        direction: SlideTransition.PresentationDirection
    ) {
        self.direction = direction
    }
}

// MARK: - UIViewControllerAnimatedTransitioning

extension SlideDismissalAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.44
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        
        var initialFrame = CGRect(
            x: fromView.frame.origin.x,
            y: fromView.frame.origin.y,
            width: fromView.frame.width,
            height: fromView.frame.height
        )
        let finalFrame = initialFrame
        
        switch direction {
        case .top:
            initialFrame.origin.y = -initialFrame.height
        case .left:
            initialFrame.origin.x = -initialFrame.width
        case .right:
            initialFrame.origin.x = transitionContext.containerView.frame.size.width
        case .bottom:
            initialFrame.origin.y = transitionContext.containerView.frame.size.height
        }
        
        let animationDuration = transitionDuration(using: transitionContext)
        
        fromView.frame = finalFrame
        
        let animator = UIViewPropertyAnimator(duration: animationDuration, dampingRatio: 0.95) {
            fromView.frame = initialFrame
        }
        animator.addCompletion { _ in
            fromView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        animator.startAnimation()
    }
}
