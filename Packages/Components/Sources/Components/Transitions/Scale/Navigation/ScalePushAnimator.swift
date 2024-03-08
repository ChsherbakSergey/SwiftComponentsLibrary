//  Created by Sergey Chsherbak on 19/02/2024.

import UIKit

public protocol ScalePushAnimatorFromDelegate: AnyObject {
    func transitionWillBegin(_ scalePushAnimator: ScalePushAnimator)
    func transitionDidEnd(_ scalePushAnimator: ScalePushAnimator)
    func originFrameForScalingView(_ scalePushAnimator: ScalePushAnimator) -> CGRect
}

public protocol ScalePushAnimatorToDelegate: AnyObject {
    func transitionWillBegin(_ scalePushAnimator: ScalePushAnimator)
    func transitionDidEnd(_ scalePushAnimator: ScalePushAnimator)
    func finalFrameForScalingView(_ scalePushAnimator: ScalePushAnimator) -> CGRect
}

public final class ScalePushAnimator: NSObject {
    
    // MARK: - UI Components
    
    private let cardView: UIView = {
        let this = UIView()
        this.backgroundColor = .systemYellow
        this.layer.cornerRadius = 20
        this.layer.cornerCurve = .continuous
        return this
    }()
    
    // MARK: - Properties
    
    weak var fromDelegate: ScalePushAnimatorFromDelegate?
    weak var toDelegate: ScalePushAnimatorToDelegate?
}

// MARK: - UIViewControllerAnimatedTransitioning

extension ScalePushAnimator: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.44
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toView)
        containerView.addSubview(cardView)
        
        toView.alpha = 0
        cardView.frame = fromDelegate?.originFrameForScalingView(self) ?? .zero
        
        let animationDuration = transitionDuration(using: transitionContext)
        
        fromDelegate?.transitionWillBegin(self)
        toDelegate?.transitionWillBegin(self)
        
        let animator = UIViewPropertyAnimator(duration: animationDuration, dampingRatio: 0.95) { [unowned self] in
            cardView.frame = toDelegate?.finalFrameForScalingView(self) ?? .zero
            cardView.layer.cornerRadius = 0
            toView.alpha = 1
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
