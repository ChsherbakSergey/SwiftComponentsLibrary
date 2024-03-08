//  Created by Sergey Chsherbak on 19/02/2024.

import UIKit

public protocol ScalePopAnimatorFromDelegate: AnyObject {
    func transitionWillBegin(_ scalePopAnimator: ScalePopAnimator)
    func transitionDidEnd(_ scalePopAnimator: ScalePopAnimator)
    func originFrameForScalingView(_ scalePopAnimator: ScalePopAnimator) -> CGRect
}

public protocol ScalePopAnimatorToDelegate: AnyObject {
    func transitionWillBegin(_ scalePopAnimator: ScalePopAnimator)
    func transitionDidEnd(_ scalePopAnimator: ScalePopAnimator)
    func finalFrameForScalingView(_ scalePopAnimator: ScalePopAnimator) -> CGRect
}

public final class ScalePopAnimator: NSObject {
    
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
    
    weak var fromDelegate: ScalePopAnimatorFromDelegate?
    weak var toDelegate: ScalePopAnimatorToDelegate?
}

// MARK: - UIViewControllerAnimatedTransitioning

extension ScalePopAnimator: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.44
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to)
        else {
            return
        }
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toView)
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
