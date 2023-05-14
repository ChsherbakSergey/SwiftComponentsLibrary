//  Created by Sergey Chsherbak on 06/05/2023.

import UIKit

final class MiniPlayerTabBarController: UITabBarController {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        setupViewControllers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViewControllers() {
        let miniPlayerViewController = MiniPlayerViewController()
        miniPlayerViewController.tabBarItem.title = "Library"
        miniPlayerViewController.tabBarItem.image = UIImage(systemName: "music.note")
        
        viewControllers = [miniPlayerViewController]
    }
}
