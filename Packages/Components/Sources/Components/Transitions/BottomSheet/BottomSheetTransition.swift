//  Created by Sergey Chsherbak on 09/02/2024.

import UIKit

public final class BottomSheetTransition: NSObject {}

// MARK: - UIViewControllerTransitioningDelegate

extension BottomSheetTransition: UIViewControllerTransitioningDelegate {
    public func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        return BottomSheetPresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
    }
    
    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return BottomSheetPresentationAnimator()
    }
    
    public func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return BottomSheetDismissalAnimator()
    }
}

extension BottomSheetTransition: UIAdaptivePresentationControllerDelegate {}
