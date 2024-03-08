////  Created by Sergey Chsherbak on 16/02/2024.
//
//import UIKit
//
//final class FlipPresentationAnimator: NSObject {
//    
//    // MARK: - Properties
//    
//    private let originFrame: CGRect
//    
//    // MARK: - Init
//    
//    init(
//        originFrame: CGRect
//    ) {
//        self.originFrame = originFrame
//    }
//}
//
//// MARK: - UIViewControllerAnimatedTransitioning
//
//extension FlipPresentationAnimator: UIViewControllerAnimatedTransitioning {
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 10
//    }
//    
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard let fromVC = transitionContext.viewController(forKey: .from),
//              let toVC = transitionContext.viewController(forKey: .to),
//              let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
//        else {
//            return
//        }
//        
//        let containerView = transitionContext.containerView
//        let finalFrame = transitionContext.finalFrame(for: toVC)
//        
//        snapshot.frame = originFrame
//        snapshot.layer.cornerRadius = 20
//        snapshot.layer.cornerCurve = .continuous
//        snapshot.layer.masksToBounds = true
//        
//        containerView.addSubview(toVC.view)
//        containerView.addSubview(snapshot)
//        toVC.view.isHidden = true
//        
//        perspectiveTransform(for: containerView)
//        snapshot.layer.transform = yRotation(.pi / 2)
//        
//        let duration = transitionDuration(using: transitionContext)
//        
//        UIView.animateKeyframes(
//            withDuration: duration,
//            delay: 0,
//            options: .calculationModeCubic
//        ) {
//            UIView.addKeyframe(
//                withRelativeStartTime: 0,
//                relativeDuration: 1 / 3) { [unowned self] in
//                    fromVC.view.layer.transform = yRotation(-.pi / 2)
//                }
//            
//            UIView.addKeyframe(
//                withRelativeStartTime: 1 / 3,
//                relativeDuration: 1 / 3) { [unowned self] in
//                    snapshot.layer.transform = yRotation(0)
//                }
//            
//            UIView.addKeyframe(
//                withRelativeStartTime: 2 / 3,
//                relativeDuration: 1 / 3
//            ) {
//                snapshot.frame = finalFrame
//                snapshot.layer.cornerRadius = 0
//            }
//        } completion: { _ in
//            toVC.view.isHidden = false
//            snapshot.removeFromSuperview()
//            fromVC.view.layer.transform = CATransform3DIdentity
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        }
//    }
//    
//    // MARK: - Helpers
//    
//    func perspectiveTransform(for containerView: UIView) {
//      var transform = CATransform3DIdentity
//      transform.m34 = -0.002
//      containerView.layer.sublayerTransform = transform
//    }
//    
//    func yRotation(_ angle: Double) -> CATransform3D {
//      return CATransform3DMakeRotation(CGFloat(angle), 0.0, 1.0, 0.0)
//    }
//}


//  Created by Sergey Chsherbak on 16/02/2024.

import UIKit

final class FlipPresentationAnimator: NSObject {
    
    // MARK: - Properties
    
    private let cardViewSnapshot: UIView
    private let originFrame: CGRect
    
    // MARK: - Init
    
    init(
        cardViewSnapshot: UIView,
        originFrame: CGRect
    ) {
        self.cardViewSnapshot = cardViewSnapshot
        self.originFrame = originFrame
    }
}

// MARK: - UIViewControllerAnimatedTransitioning

extension FlipPresentationAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 10
    }
    
    /// No need for the fromView. Copy the snapshot of the fromView.cardView. add it here, transform, then toView.cardView animate to the top of the toView.
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to),
              let snapshot = toView.snapshotView(afterScreenUpdates: true)
        else {
            return
        }
        
        let containerView = transitionContext.containerView
        let finalFrame = containerView.bounds
        
        snapshot.frame = originFrame
        snapshot.layer.cornerRadius = 20
        snapshot.layer.cornerCurve = .continuous
        snapshot.layer.masksToBounds = true
        
        cardViewSnapshot.frame = originFrame
        cardViewSnapshot.layer.cornerRadius = 20
        cardViewSnapshot.layer.cornerCurve = .continuous
        cardViewSnapshot.layer.masksToBounds = true
        
        containerView.addSubview(toView)
//        containerView.addSubview(cardViewSnapshot)
        containerView.addSubview(snapshot)
        toView.isHidden = true
        
        perspectiveTransform(for: containerView)
        snapshot.layer.transform = yRotation(.pi / 2)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic
        ) {
            UIView.addKeyframe(
                withRelativeStartTime: 0,
                relativeDuration: 1 / 3) { [unowned self] in
//                    fromView.layer.transform = yRotation(-.pi / 2)
                    cardViewSnapshot.layer.transform = yRotation(-.pi / 2)
                }
            
            UIView.addKeyframe(
                withRelativeStartTime: 1 / 3,
                relativeDuration: 1 / 3) { [unowned self] in
                    snapshot.layer.transform = yRotation(0)
                }
            
            UIView.addKeyframe(
                withRelativeStartTime: 2 / 3,
                relativeDuration: 1 / 3
            ) {
                snapshot.frame = finalFrame
                snapshot.layer.cornerRadius = 0
            }
        } completion: { _ in
            toView.isHidden = false
            snapshot.removeFromSuperview()
//            self.cardViewSnapshot.removeFromSuperview()
//            fromView.layer.transform = CATransform3DIdentity
            self.cardViewSnapshot.layer.transform = CATransform3DIdentity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    // MARK: - Helpers
    
    func perspectiveTransform(for containerView: UIView) {
      var transform = CATransform3DIdentity
      transform.m34 = -0.002
      containerView.layer.sublayerTransform = transform
    }
    
    func yRotation(_ angle: Double) -> CATransform3D {
      return CATransform3DMakeRotation(CGFloat(angle), 0.0, 1.0, 0.0)
    }
}
