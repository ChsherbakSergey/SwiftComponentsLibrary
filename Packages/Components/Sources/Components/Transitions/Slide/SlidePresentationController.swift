//  Created by Sergey Chsherbak on 13/02/2024.

import UIKit

final class SlidePresentationController: UIPresentationController {
    
    // MARK: - UI Components
    
    private let dimmingView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.backgroundColor = .black.withAlphaComponent(0.4)
        this.alpha = 0
        return this
    }()
    
    // MARK: - Propeties
    
    private let direction: SlideTransition.PresentationDirection
    
    // MARK: - Overriden Properties
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView else {
            return super.frameOfPresentedViewInContainerView
        }
        
        var frame = CGRect.zero
        frame.size = size(
            forChildContentContainer: presentedViewController,
            withParentContainerSize: containerView.bounds.size
        )
        
        switch direction {
        case .top:
            frame.origin = .zero
        case .left:
            frame.origin = .zero
        case .right:
            frame.origin.x = containerView.frame.width * 0.25
        case .bottom:
            frame.origin.y = containerView.frame.height * 0.25
        
        }
        
        return frame
    }
    
    // MARK: - Init
    
    init(
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?,
        direction: SlideTransition.PresentationDirection
    ) {
        self.direction = direction
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        setupGestures()
    }
    
    // MARK: - Setup
    
    private func setupGestures() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapDimmingView(_:))
        )
        dimmingView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - Actions
    
    @objc private func didTapDimmingView(_ gestureRecognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
    
    // MARK: - Overriden Methods
    
    override func presentationTransitionWillBegin() {
        guard let containerView else { return }
        
        containerView.addSubview(dimmingView)
        
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        presentedViewController.transitionCoordinator?.animate { [weak self] _ in
            self?.dimmingView.alpha = 1
        }
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate { [weak self] _ in
            self?.dimmingView.alpha = 0
        }
    }
    
    override func size(
        forChildContentContainer container: UIContentContainer,
        withParentContainerSize parentSize: CGSize
    ) -> CGSize {
        switch direction {
        case .left, .right:
            return CGSize(width: parentSize.width * 0.75, height: parentSize.height)
        case .bottom, .top:
            return CGSize(width: parentSize.width, height: parentSize.height * 0.75)
        }
    }
}
