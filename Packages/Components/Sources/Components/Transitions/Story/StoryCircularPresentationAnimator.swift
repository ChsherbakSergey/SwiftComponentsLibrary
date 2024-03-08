//  Created by Sergey Chsherbak on 21/02/2024.

import UIKit

public final class StoryCircularPresentationAnimator: NSObject {
    
    // MARK: - UI Components
    
    private let circleView: UIView = {
        let this = UIView()
        return this
    }()
    
    // MARK: - Properties
    
    private let originPoint: CGPoint
    
    // MARK: - Init
    
    public init(originPoint: CGPoint) {
        self.originPoint = originPoint
    }
    
    // MARK: - Methods
    
    private func frameForCircleView(
        withCenter center: CGPoint,
        size: CGSize,
        originPoint: CGPoint
    ) -> CGRect {
        let xLength = fmax(originPoint.x, size.width - originPoint.x)
        let yLenght = fmax(originPoint.y, size.height - originPoint.y)
        
        let offsetVector = sqrt(xLength * xLength + yLenght * yLenght) * 2
        let size = CGSize(width: offsetVector, height: offsetVector)
        
        return CGRect(origin: .zero, size: size)
    }
}

// MARK: - UIViewControllerAnimatedTransitioning

extension StoryCircularPresentationAnimator: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.44
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        let toViewCenter = toView.center
        let toViewSize = toView.frame.size
        let circleViewFrame = frameForCircleView(
            withCenter: toViewCenter,
            size: toViewSize,
            originPoint: originPoint
        )
        
        containerView.addSubview(toView)
        
        circleView.frame = circleViewFrame
        circleView.layer.cornerRadius = circleView.frame.height / 2
        circleView.center = originPoint
        
        toView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        toView.center = originPoint
        
        let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.95) {
            toView.center = toViewCenter
            toView.transform = .identity
        }
        animator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        animator.startAnimation()
    }
}


//  Created by Sergey Chsherbak on 21/02/2024.

//import UIKit
//
//public final class StoryCircularPresentationAnimator: NSObject {
//    
//    // MARK: - UI Components
//    
//    private let circleView: UIView = {
//        let this = UIView()
//        return this
//    }()
//    
//    // MARK: - Properties
//    
//    private let originFrame: CGRect
//    
//    // MARK: - Init
//    
//    public init(originFrame: CGRect) {
//        self.originFrame = originFrame
//    }
//}
//
//// MARK: - UIViewControllerAnimatedTransitioning
//
//extension StoryCircularPresentationAnimator: UIViewControllerAnimatedTransitioning {
//    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 3
//    }
//    
//    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard let toView = transitionContext.view(forKey: .to) else { return }
//        
//        let containerView = transitionContext.containerView
//        let duration = transitionDuration(using: transitionContext)
//        
//        containerView.addSubview(toView)
//        
//        circleView.frame = originFrame
//        circleView.layer.cornerRadius = circleView.frame.height / 2
//        
//        toView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
//        toView.center = originPoint
//        
//        let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.95) {
//            toView.center = toViewCenter
//            toView.transform = .identity
//        }
//        animator.addCompletion { _ in
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        }
//        animator.startAnimation()
//    }
//}
