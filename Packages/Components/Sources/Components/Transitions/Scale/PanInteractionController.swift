//  Created by Sergey Chsherbak on 21/02/2024.

import UIKit

public protocol PanInteractionControllerDelegate: AnyObject {
    func interactiveAnimationDidStart(_ interactionController: PanInteractionController)
}

public final class PanInteractionController: UIPercentDrivenInteractiveTransition {
    
    // MARK: - Properties
    
    public weak var delegate: PanInteractionControllerDelegate?
    
    public var isActive: Bool {
        return panGestureRecognizer?.state != .possible
    }
    
    private var panGestureRecognizer: UIPanGestureRecognizer?
    
    // MARK: - Methods
    
    public func attachTo(view: UIView) {
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panGestureRecognizer!)
    }
    
    // MARK: - Actions
    
    @objc private func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let view = gestureRecognizer.view else { return }
        
        switch gestureRecognizer.state {
        case .began:
            let location = gestureRecognizer.location(in: view)
            if location.x < view.bounds.midX {
                delegate?.interactiveAnimationDidStart(self)
            }
        case .changed:
            let translation = gestureRecognizer.translation(in: view)
            let percent = abs(translation.x / view.bounds.width)
            update(percent)
        case .ended:
            if gestureRecognizer.velocity(in: view).x > 0 {
                finish()
            } else {
                cancel()
            }
        case .cancelled:
            fallthrough
        case .failed:
            cancel()
        case .recognized:
            break
        case .possible:
            break
        @unknown default:
            break
        }
    }
}
