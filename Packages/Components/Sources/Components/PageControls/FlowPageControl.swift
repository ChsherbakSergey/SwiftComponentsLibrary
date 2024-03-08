//  Created by Sergey Chsherbak on 26/02/2024.

import UIKit

public final class FlowPageControl: UIView {
    
    // MARK: - UI Elements
    
    private var pageIndicatorViews: [UIView] = []
    
    // MARK: - Properties
    
    public var numberOfPages = 0
    public var currentPage = 0 {
        didSet {
            let index = max(min(currentPage, numberOfPages), 0)
            
            guard oldValue != index else { return }
            
//            index < oldValue ? backward() : forward()
        }
    }
    
    public var pageIndicatorTintColor: UIColor = .systemGray5
    public var currentPageIndicatorTintColor: UIColor = .systemBlue
    
    /// The distance in points between the adjecent edges of the flow page control's arranged views.
    public var spacing: CGFloat = 4
    
    /// The value used to scale the current page indicator view.
    public var scalingFactor: CGFloat = 2.8125
    
    public var animator: UIViewPropertyAnimator?
    
    // MARK: - Overriden Properties
    
    public override var bounds: CGRect {
        didSet {
            guard bounds != oldValue else { return }
            
            updateView()
        }
    }
    
    // MARK: - Private Properties
    
    private var isAnimatingForward = false
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .clear
    }
    
    private func updateView() {
        for pageIndicatorView in pageIndicatorViews {
            pageIndicatorView.removeFromSuperview()
        }
        pageIndicatorViews.removeAll()
        
        let availableWidth = bounds.width - spacing * CGFloat((numberOfPages - 1))
        let pageIndicatorWidth = availableWidth / (CGFloat(numberOfPages - 1) + scalingFactor)
        let currentPageIndicatorWidth = pageIndicatorWidth * 2.72
        var xPosition: CGFloat = 0
        
        for index in 0..<numberOfPages {
            let pageIndicatorViewFrame: CGRect
            
            if index == currentPage {
                pageIndicatorViewFrame = CGRect(x: xPosition, y: 0, width: currentPageIndicatorWidth, height: bounds.height)
                xPosition += index == numberOfPages - 1 ? currentPageIndicatorWidth : currentPageIndicatorWidth + spacing
            } else {
                pageIndicatorViewFrame = CGRect(x: xPosition, y: 0, width: pageIndicatorWidth, height: bounds.height)
                xPosition += index == numberOfPages - 1 ? pageIndicatorWidth : pageIndicatorWidth + spacing
            }
            
            let view = UIView(frame: pageIndicatorViewFrame)
            view.backgroundColor = index == currentPage ? currentPageIndicatorTintColor : pageIndicatorTintColor
            view.layer.cornerRadius = 3
            
            pageIndicatorViews.append(view)
            addSubview(view)
        }
    }
    
    private func backward() {
        let currentPageIndicatorView = pageIndicatorViews[currentPage]
        let nextPageIndicatorView = pageIndicatorViews[currentPage + 1]
        let currentPageIndicatorViewWidth = currentPageIndicatorView.frame.size.width * scalingFactor
        let nextPageIndicatorViewWidth = nextPageIndicatorView.frame.size.width / scalingFactor
        let nextPageIndicatorViewOriginX = currentPageIndicatorView.frame.origin.x + currentPageIndicatorViewWidth + spacing
        
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut)
        animator.addAnimations { [unowned self] in
            currentPageIndicatorView.frame.size.width = currentPageIndicatorViewWidth
            nextPageIndicatorView.frame.origin.x = nextPageIndicatorViewOriginX
            currentPageIndicatorView.backgroundColor = currentPageIndicatorTintColor
            nextPageIndicatorView.frame.size.width = nextPageIndicatorViewWidth
            nextPageIndicatorView.backgroundColor = pageIndicatorTintColor
        }
        
        animator.startAnimation()
    }
    
    private func forward() {
        let currentPageIndicatorView = pageIndicatorViews[currentPage]
        let previousPageIndicatorView = pageIndicatorViews[currentPage - 1]
        let currentPageIndicatorViewWidth = currentPageIndicatorView.frame.size.width * scalingFactor
        let previousPageIndicatorViewWidth = previousPageIndicatorView.frame.size.width / scalingFactor
        let currentPageIndicatorViewOriginX = previousPageIndicatorView.frame.origin.x + previousPageIndicatorViewWidth + spacing
        
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut)
        animator.addAnimations { [unowned self] in
            currentPageIndicatorView.frame.size.width = currentPageIndicatorViewWidth
            currentPageIndicatorView.frame.origin.x = currentPageIndicatorViewOriginX
            currentPageIndicatorView.backgroundColor = currentPageIndicatorTintColor
            previousPageIndicatorView.frame.size.width = previousPageIndicatorViewWidth
            previousPageIndicatorView.backgroundColor = pageIndicatorTintColor
        }
        
        animator.startAnimation()
    }
    
//    private func createNewAnimatorIfNeeded(basedOnFractionComplete fractionComplete: CGFloat) {
//        guard fractionComplete != 0 else { return }
//        
//        if -1...0 ~= fractionComplete {
//            if animator != nil {
//                animator?.stopAnimation(true)
//                animator?.finishAnimation(at: .current)
//                animator = nil
//            } else {
//                let currentPageIndicatorView = pageIndicatorViews[currentPage]
//                let nextPageIndicatorView = pageIndicatorViews[currentPage + 1]
//                let currentPageIndicatorViewWidth = currentPageIndicatorView.frame.size.width * scalingFactor
//                let nextPageIndicatorViewWidth = nextPageIndicatorView.frame.size.width / scalingFactor
//                let nextPageIndicatorViewOriginX = currentPageIndicatorView.frame.origin.x + currentPageIndicatorViewWidth + spacing
//                
//                animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut)
//                animator?.addAnimations { [unowned self] in
//                    currentPageIndicatorView.frame.size.width = currentPageIndicatorViewWidth
//                    nextPageIndicatorView.frame.origin.x = nextPageIndicatorViewOriginX
//                    currentPageIndicatorView.backgroundColor = currentPageIndicatorTintColor
//                    nextPageIndicatorView.frame.size.width = nextPageIndicatorViewWidth
//                    nextPageIndicatorView.backgroundColor = pageIndicatorTintColor
//                }
//            }
//        } else if 0...1 ~= fractionComplete {
//            if animator != nil {
//                animator?.stopAnimation(true)
//                animator?.finishAnimation(at: .current)
//                animator = nil
//            } else {
//                print("Here")
//                let currentPageIndicatorView = pageIndicatorViews[currentPage + 1]
//                let previousPageIndicatorView = pageIndicatorViews[currentPage]
//                let currentPageIndicatorViewWidth = currentPageIndicatorView.frame.size.width * scalingFactor
//                let previousPageIndicatorViewWidth = previousPageIndicatorView.frame.size.width / scalingFactor
//                let currentPageIndicatorViewOriginX = previousPageIndicatorView.frame.origin.x + previousPageIndicatorViewWidth + spacing
//                
//                animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut)
//                animator?.addAnimations { [unowned self] in
//                    currentPageIndicatorView.frame.size.width = currentPageIndicatorViewWidth
//                    currentPageIndicatorView.frame.origin.x = currentPageIndicatorViewOriginX
//                    currentPageIndicatorView.backgroundColor = currentPageIndicatorTintColor
//                    previousPageIndicatorView.frame.size.width = previousPageIndicatorViewWidth
//                    previousPageIndicatorView.backgroundColor = pageIndicatorTintColor
//                }
//            }
//        }
//    }
    
    private func createNewAnimatorIfNeeded(basedOnFractionComplete fractionComplete: CGFloat) {
        if fractionComplete == 0 {
            return
        }
        
        if animator == nil {
            if -1...0 ~= fractionComplete {
                isAnimatingForward = false
                let currentPageIndicatorView = pageIndicatorViews[currentPage - 1]
                let previousPageIndicatorView = pageIndicatorViews[currentPage]
                let currentPageIndicatorViewWidth = currentPageIndicatorView.frame.size.width * scalingFactor
                let previousPageIndicatorViewWidth = previousPageIndicatorView.frame.size.width / scalingFactor
                let previousPageIndicatorViewOriginX = currentPageIndicatorView.frame.origin.x + currentPageIndicatorViewWidth + spacing
                
                animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut)
                animator?.addAnimations { [unowned self] in
                    currentPageIndicatorView.frame.size.width = currentPageIndicatorViewWidth
                    previousPageIndicatorView.frame.origin.x = previousPageIndicatorViewOriginX
                    previousPageIndicatorView.frame.size.width = previousPageIndicatorViewWidth
                    currentPageIndicatorView.backgroundColor = currentPageIndicatorTintColor
                    previousPageIndicatorView.backgroundColor = pageIndicatorTintColor
                }
            } else if 0...1 ~= fractionComplete {
                isAnimatingForward = true
                let currentPageIndicatorView = pageIndicatorViews[currentPage + 1]
                let previousPageIndicatorView = pageIndicatorViews[currentPage]
                let currentPageIndicatorViewWidth = currentPageIndicatorView.frame.size.width * scalingFactor
                let previousPageIndicatorViewWidth = previousPageIndicatorView.frame.size.width / scalingFactor
                let currentPageIndicatorViewOriginX = previousPageIndicatorView.frame.origin.x + previousPageIndicatorViewWidth + spacing
                
                animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut)
                animator?.addAnimations { [unowned self] in
                    currentPageIndicatorView.frame.size.width = currentPageIndicatorViewWidth
                    currentPageIndicatorView.frame.origin.x = currentPageIndicatorViewOriginX
                    currentPageIndicatorView.backgroundColor = currentPageIndicatorTintColor
                    previousPageIndicatorView.frame.size.width = previousPageIndicatorViewWidth
                    previousPageIndicatorView.backgroundColor = pageIndicatorTintColor
                }
            }
        } else if fractionComplete <= -1 {
            animator?.stopAnimation(true)
            animator?.finishAnimation(at: .end)
            animator = nil
            currentPage -= 1
            return
        } else if fractionComplete >= 1 {
            animator?.stopAnimation(true)
            animator?.finishAnimation(at: .end)
            animator = nil
            currentPage += 1
            return
        }
        
        print(fractionComplete)
    }
    
    public func animateBasedOn(fractionComplete: CGFloat) {
        if isAnimatingForward && fractionComplete < 0 {
            animator?.stopAnimation(true)
            animator?.finishAnimation(at: .end)
            animator = nil
        } else if !isAnimatingForward && fractionComplete > 0 {
            animator?.stopAnimation(true)
            animator?.finishAnimation(at: .end)
            animator = nil
        }
        
        createNewAnimatorIfNeeded(basedOnFractionComplete: fractionComplete)
        if -1...0 ~= fractionComplete {
            animator?.fractionComplete = fractionComplete * -1
        } else if 0...1 ~= fractionComplete {
            animator?.fractionComplete = fractionComplete
        }

        // Fraction complete can be in the region from -1 to 1.
        // Where -1 means we should animate to the previous page.
        // 0 means we are at the same page
        // 1 means we should animate to the next page.
    }
}


//                    currentPageIndicatorView.frame.size.width = currentPageIndicatorViewWidth
//                    nextPageIndicatorView.frame.origin.x = nextPageIndicatorViewOriginX
//                    currentPageIndicatorView.backgroundColor = currentPageIndicatorTintColor
//                    nextPageIndicatorView.frame.size.width = nextPageIndicatorViewWidth
//                    nextPageIndicatorView.backgroundColor = pageIndicatorTintColor

//                let currentPageIndicatorView = pageIndicatorViews[currentPage]
//                let nextPageIndicatorView = pageIndicatorViews[currentPage - 1]
//                let currentPageIndicatorViewWidth = currentPageIndicatorView.frame.size.width / scalingFactor
//                let nextPageIndicatorViewWidth = nextPageIndicatorView.frame.size.width * scalingFactor
//                let nextPageIndicatorViewOriginX = currentPageIndicatorView.frame.origin.x + currentPageIndicatorViewWidth + spacing
                
//                animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut)
//                animator?.addAnimations { [unowned self] in
//                    currentPageIndicatorView.frame.size.width = currentPageIndicatorViewWidth
//                    nextPageIndicatorView.frame.origin.x = nextPageIndicatorViewOriginX
//                    currentPageIndicatorView.backgroundColor = currentPageIndicatorTintColor
//                    nextPageIndicatorView.frame.size.width = nextPageIndicatorViewWidth
//                    nextPageIndicatorView.backgroundColor = pageIndicatorTintColor
//                }
