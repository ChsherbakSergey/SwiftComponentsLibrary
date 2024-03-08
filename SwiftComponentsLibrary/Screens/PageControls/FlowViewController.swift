//  Created by Sergey Chsherbak on 29/02/2024.

import Components
import UIKit

final class FlowViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let containerView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        return this
    }()
    
    private let pageViewController = FlowPageControlPageViewController()
    
    private let backwardButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        this.setTitle("Backward", for: .normal)
        this.backgroundColor = .systemRed
        this.layer.cornerCurve = .continuous
        this.layer.cornerRadius = 12
        return this
    }()
    
    private let forwardButton: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        this.setTitle("Forward", for: .normal)
        this.backgroundColor = .systemGreen
        this.layer.cornerCurve = .continuous
        this.layer.cornerRadius = 12
        return this
    }()
    
    private let buttonsStackView: UIStackView = {
        let this = UIStackView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.distribution = .fillEqually
        this.spacing = 16
        return this
    }()
    
    private let pageControl: FlowPageControl = {
        let this = FlowPageControl()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.numberOfPages = 3
        return this
    }()
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        title = "Flow Page Control View"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupSubviews()
        setupDelegates()
        setupTargets()
    }
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        pageViewController.numberOfPages = 3
    }
    
    private func setupSubviews() {
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -160)
        ])
        
        addChild(pageViewController)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(pageViewController.view)
        
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        pageViewController.didMove(toParent: self)
        
        buttonsStackView.addArrangedSubview(backwardButton)
        buttonsStackView.addArrangedSubview(forwardButton)
        view.addSubview(buttonsStackView)
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            backwardButton.heightAnchor.constraint(equalToConstant: 48),
            forwardButton.heightAnchor.constraint(equalToConstant: 48),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            pageControl.heightAnchor.constraint(equalToConstant: 6),
            pageControl.widthAnchor.constraint(equalToConstant: 84)
        ])
    }
    
    private func setupDelegates() {
        pageViewController.pageDelegate = self
    }
    
    private func setupTargets() {
        backwardButton.addTarget(
            self,
            action: #selector(didTapBackwardButton),
            for: .touchUpInside
        )
        forwardButton.addTarget(
            self,
            action: #selector(didTapForwardButton),
            for: .touchUpInside
        )
    }
    
    // MARK: - Actions
    
    @objc private func didTapBackwardButton() {
        pageViewController.backward()
//        pageControl.currentPage = pageViewController.currentPage
    }
    
    @objc private func didTapForwardButton() {
        pageViewController.forward()
//        pageControl.currentPage = pageViewController.currentPage
    }
}

// MARK: - FlowPageControlPageViewControllerDelegate

extension FlowViewController: FlowPageControlPageViewControllerDelegate {
    func flowPageControlPageViewController(
        _ pageViewController: FlowPageControlPageViewController,
        didAnimateToPageIndex pageIndex: Int
    ) {
        pageControl.currentPage = pageViewController.currentPage
    }
    
    func flowPageControlPageViewController(
        _ pageViewController: FlowPageControlPageViewController,
        didAnimateUntilFractionComplete fractionComplete: CGFloat
    ) {
        pageControl.animateBasedOn(fractionComplete: fractionComplete)
    }
    
//    func flowPageControlPageViewController(
//        _ pageViewController: FlowPageControlPageViewController,
//        didAnimateUntilFractionComplete fractionComplete: CGFloat
//    ) {
//        guard fractionComplete != 0 else { return }
        
//        if fractionComplete >= 1 {
//            pageViewController.forward()
////            pageControl.currentPage = pageViewController.currentPage
//        } else if fractionComplete <= -1 {
//            pageViewController.backward()
////            pageControl.currentPage = pageViewController.currentPage
//        }
        
//        pageControl.makeAnimator()
//        pageControl.forward(fractionComplete: fractionComplete)
//    }
}
