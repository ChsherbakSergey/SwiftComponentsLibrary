//  Created by Sergey Chsherbak on 21/02/2024.

import UIKit

public final class StoryCircularDismissalAnimator: NSObject {
    
    // MARK: - Properties
    
    private let originPoint: CGPoint
    
    // MARK: - Init
    
    public init(originPoint: CGPoint) {
        self.originPoint = originPoint
    }
    
}

extension StoryCircularDismissalAnimator: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.38
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        
        containerView.addSubview(fromView)
        
        let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.95) { [unowned self] in
            fromView.center = self.originPoint
            fromView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        }
        animator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        animator.startAnimation()
    }
}
