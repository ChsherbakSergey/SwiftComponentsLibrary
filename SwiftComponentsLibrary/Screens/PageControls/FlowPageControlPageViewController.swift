//  Created by Sergey Chsherbak on 29/02/2024.

import UIKit

protocol FlowPageControlPageViewControllerDelegate: AnyObject {
    func flowPageControlPageViewController(_ pageViewController: FlowPageControlPageViewController, didAnimateUntilFractionComplete fractionComplete: CGFloat)
    func flowPageControlPageViewController(_ pageViewController: FlowPageControlPageViewController, didAnimateToPageIndex pageIndex: Int)
}

final class FlowPageControlPageViewController: UIPageViewController {
    
    // MARK: - Properties
    
    private var pageControllers: [UIViewController] = []
    
    public var numberOfPages: Int = 0
    public var currentPage: Int = 0
    
    weak var pageDelegate: FlowPageControlPageViewControllerDelegate?
    
    // MARK: - Init
    
    override init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey : Any]? = nil
    ) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupViewControllers()
    }
    
    // MARK: - Internal Methods
    
    func goToPage(atIndex index: Int) {
        guard let currentViewController = viewControllers?.first else { return }
        
        let currentViewControllerIndex = pageControllers.firstIndex(of: currentViewController) ?? 0
        let direction: NavigationDirection = index > currentViewControllerIndex ? .forward : .reverse
        
        currentPage = index
        setViewControllers([pageControllers[index]], direction: direction, animated: true)
    }
    
    func backward() {
        guard let currentViewController = viewControllers?.first else { return }
        
        let currentViewControllerIndex = pageControllers.firstIndex(of: currentViewController) ?? 0
        let index = max(currentViewControllerIndex - 1, 0)
        
        currentPage = index
        setViewControllers([pageControllers[index]], direction: .reverse, animated: true)
    }
    
    func forward() {
        guard let currentViewController = viewControllers?.first else { return }
        
        let currentViewControllerIndex = pageControllers.firstIndex(of: currentViewController) ?? 0
        let index = min(currentViewControllerIndex + 1, numberOfPages - 1)
        
        currentPage = index
        setViewControllers([pageControllers[index]], direction: .forward, animated: true)
    }
    
    // MARK: - Setup
    
    private func setupDelegates() {
        dataSource = self
        delegate = self
        
        for subview in view.subviews {
            if let scrollView = subview as? UIScrollView {
                scrollView.delegate = self
            }
        }
    }
    
    private func setupViewControllers() {
        for _ in 0..<numberOfPages {
            let viewController = FlowPageControlViewController()
            pageControllers.append(viewController)
        }
        
        setViewControllers([pageControllers[0]], direction: .forward, animated: true)
    }
}

// MARK: - UIScrollViewDelegate

extension FlowPageControlPageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let fractionComplete = (offset - view.bounds.width) / view.bounds.width
        
        pageDelegate?.flowPageControlPageViewController(self, didAnimateUntilFractionComplete: fractionComplete)
    }
}

// MARK: - UIPageViewControllerDataSource

extension FlowPageControlPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        if let index = pageControllers.firstIndex(of: viewController) {
            if index > 0 {
                return pageControllers[index - 1]
            } else {
                return nil
            }
        }
        
        return nil
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        if let index = pageControllers.firstIndex(of: viewController) {
            if index < pageControllers.count - 1 {
                return pageControllers[index + 1]
            } else {
                return nil
            }
        }
        
        return nil
    }
}

// MARK: - UIPageViewControllerDelegate

extension FlowPageControlPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        if let currentPageController = pageViewController.viewControllers?.first {
            let index = pageControllers.firstIndex(of: currentPageController) ?? 0
            currentPage = index
            
//            pageDelegate?.flowPageControlPageViewController(self, didAnimateToPageIndex: index)
        }
    }
}
