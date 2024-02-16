//  Created by Sergey Chsherbak on 13/02/2024.

import UIKit

public final class SlideTransition: NSObject {
    
    // MARK: - Properties
    
    public var direction: PresentationDirection = .right
}

public extension SlideTransition {
    enum PresentationType {
        case presentation
        case dismissal
    }
    
    enum PresentationDirection {
        case top
        case left
        case right
        case bottom
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension SlideTransition: UIViewControllerTransitioningDelegate {
    public func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        return SlidePresentationController(
            presentedViewController: presented,
            presenting: presenting,
            direction: direction
        )
    }
    
    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return SlidePresentationAnimator(direction: direction)
    }
    
    public func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return SlideDismissalAnimator(direction: direction)
    }
}
