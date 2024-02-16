//  Created by Sergey Chsherbak on 13/02/2024.

import UIKit

final class SlidePresentationAnimator: NSObject {
    
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

extension SlidePresentationAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.44
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(toView)
        
        var initialFrame = CGRect(
            x: toView.frame.origin.x,
            y: toView.frame.origin.y,
            width: toView.frame.width,
            height: toView.frame.height
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
