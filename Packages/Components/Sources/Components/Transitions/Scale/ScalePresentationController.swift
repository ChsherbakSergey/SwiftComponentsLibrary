//  Created by Sergey Chsherbak on 19/02/2024.

import UIKit

final class ScalePresentationController: UIPresentationController {
    
    // MARK: - Properties
    
    var wantsInteractiveDismissal = false
    
    // MARK: - Init
    
    override init(
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?
    ) {
        super.init(
            presentedViewController: presentedViewController,
            presenting: presentingViewController
        )
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {}
}
