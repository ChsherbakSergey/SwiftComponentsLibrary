//  Created by Sergey Chsherbak on 16/02/2024.

import UIKit

public final class FlipTransition: NSObject {
    
    // MARK: - Properties
    
    private let cardViewSnapshot: UIView
    private let originFrame: CGRect
    
    // MARK: - Init
    
    public init(
        cardViewSnapshot: UIView,
        originFrame: CGRect
    ) {
        self.cardViewSnapshot = cardViewSnapshot
        self.originFrame = originFrame
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension FlipTransition: UIViewControllerTransitioningDelegate {
    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        FlipPresentationAnimator(
            cardViewSnapshot: cardViewSnapshot,
            originFrame: originFrame
        )
    }
}
