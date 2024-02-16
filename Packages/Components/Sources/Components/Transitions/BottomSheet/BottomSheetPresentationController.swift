//  Created by Sergey Chsherbak on 10/02/2024.

import UIKit

final class BottomSheetPresentationController: UIPresentationController {
    
    // MARK: - UI Components
    
    private let dimmingView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.backgroundColor = .black.withAlphaComponent(0.4)
        this.alpha = 0
        return this
    }()
    
    // MARK: - Init
    
    override init(
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?
    ) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        setupGestures()
    }
    
    // MARK: - Overriden Properties
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView else {
            return super.frameOfPresentedViewInContainerView
        }
        
        return CGRect(
            x: 0,
            y: containerView.frame.height - 300,
            width: containerView.frame.width,
            height: 300
        )
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
        super.presentationTransitionWillBegin()
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
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        presentedViewController.transitionCoordinator?.animate { [weak self] _ in
            self?.dimmingView.alpha = 0
        }
    }
}
