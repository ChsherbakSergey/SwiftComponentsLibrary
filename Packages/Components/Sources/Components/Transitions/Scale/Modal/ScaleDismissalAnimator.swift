//  Created by Sergey Chsherbak on 18/02/2024.

import UIKit

public protocol ScaleDismissalAnimatorFromDelegate: AnyObject {
    func transitionWillBegin(_ scaleDismissalAnimator: ScaleDismissalAnimator)
    func transitionDidEnd(_ scaleDismissalAnimator: ScaleDismissalAnimator)
    func originFrameForScalingView(_ scaleDismissalAnimator: ScaleDismissalAnimator) -> CGRect
}

public protocol ScaleDismissalAnimatorToDelegate: AnyObject {
    func transitionWillBegin(_ scaleDismissalAnimator: ScaleDismissalAnimator)
    func transitionDidEnd(_ scaleDismissalAnimator: ScaleDismissalAnimator)
    func finalFrameForScalingView(_ scaleDismissalAnimator: ScaleDismissalAnimator) -> CGRect
}

public final class ScaleDismissalAnimator: NSObject {
    
    // MARK: - UI Components
    
    private let cardView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.backgroundColor = .systemYellow
        this.layer.cornerRadius = 0
        this.layer.cornerCurve = .continuous
        return this
    }()
    
    // MARK: - Properties
    
    weak var fromDelegate: ScaleDismissalAnimatorFromDelegate?
    weak var toDelegate: ScaleDismissalAnimatorToDelegate?
}

// MARK: - UIViewControllerAnimatedTransitioning

extension ScaleDismissalAnimator: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.44
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else {
            return
        }

        let containerView = transitionContext.containerView
        
        containerView.addSubview(fromView)
        containerView.addSubview(cardView)
        
        fromView.alpha = 1
        cardView.frame = fromDelegate?.originFrameForScalingView(self) ?? .zero
        
        let animationDuration = transitionDuration(using: transitionContext)
        
        fromDelegate?.transitionWillBegin(self)
        toDelegate?.transitionWillBegin(self)
        
        let animator = UIViewPropertyAnimator(duration: animationDuration, dampingRatio: 0.95) { [unowned self] in
            fromView.alpha = 0
            cardView.frame = toDelegate?.finalFrameForScalingView(self) ?? .zero
            cardView.layer.cornerRadius = 20
        }
        animator.addCompletion { [unowned self] _ in
            cardView.removeFromSuperview()
            fromDelegate?.transitionDidEnd(self)
            toDelegate?.transitionDidEnd(self)
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        animator.startAnimation()
    }
}
