//  Created by Sergey Chsherbak on 17/02/2024.

import UIKit

public protocol ScalePresentationAnimatorFromDelegate: AnyObject {
    func transitionWillBegin(_ scalePresentationAnimator: ScalePresentationAnimator)
    func transitionDidEnd(_ scalePresentationAnimator: ScalePresentationAnimator)
    func originFrameForScalingView(_ scalePresentationAnimator: ScalePresentationAnimator) -> CGRect
}

public protocol ScalePresentationAnimatorToDelegate: AnyObject {
    func transitionWillBegin(_ scalePresentationAnimator: ScalePresentationAnimator)
    func transitionDidEnd(_ scalePresentationAnimator: ScalePresentationAnimator)
    func finalFrameForScalingView(_ scalePresentationAnimator: ScalePresentationAnimator) -> CGRect
}

public final class ScalePresentationAnimator: NSObject {
    
    // MARK: - UI Components
    
    private let cardView: UIView = {
        let this = UIView()
        this.backgroundColor = .systemYellow
        this.layer.cornerRadius = 20
        this.layer.cornerCurve = .continuous
        return this
    }()
    
    // MARK: - Properties
    
    weak var fromDelegate: ScalePresentationAnimatorFromDelegate?
    weak var toDelegate: ScalePresentationAnimatorToDelegate?
}

// MARK: - UIViewControllerAnimatedTransitioning

extension ScalePresentationAnimator: UIViewControllerAnimatedTransitioning {
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
        
        toView.frame = transitionContext.containerView.frame
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
