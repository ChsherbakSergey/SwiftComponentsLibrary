//  Created by Sergey Chsherbak on 21/02/2024.

import Components
import UIKit

final class StoryTransitionViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = StoryTransitionContentView()
    
    private lazy var dataSource = makeDataSource()
    
    private var selectedStoryCell: StoryCollectionViewCell?
    
    private var originPointForAnimation: CGPoint {
        guard let center = selectedStoryCell?.center,
              let navigationBarHeight = navigationController?.navigationBar.frame.height,
              let navigationBarYOffset = navigationController?.navigationBar.frame.origin.y
        else {
            return .zero
        }
        
        return CGPoint(x: center.x, y: center.y + navigationBarHeight + navigationBarYOffset)
    }
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Story Transition"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupDelegates()
        applySnapshot(with: [
            .systemRed,
            .systemOrange,
            .systemYellow,
            .systemGreen,
            .systemMint,
            .systemTeal,
            .systemCyan,
            .systemBlue,
            .systemIndigo,
            .systemPurple,
            .systemPink,
            .systemBrown,
        ])
    }
    
    // MARK: - Setup
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupDelegates() {
        contentView.collectionView.delegate = self
    }
}

// MARK: - CollectionViewDataSource

private extension StoryTransitionViewController {
    func makeDataSource() -> DataSource {
        let storyCellRegistration = UICollectionView.CellRegistration<StoryCollectionViewCell, UIColor> { cell, indexPath, color in
            cell.configure(with: color)
        }
        let dataSource = DataSource(
            collectionView: contentView.collectionView
        ) { collectionView, indexPath, item in
            let cell = collectionView.dequeueConfiguredReusableCell(using: storyCellRegistration, for: indexPath, item: item)
            return cell
        }
        return dataSource
    }
    
    func applySnapshot(
        with stories: [UIColor],
        animatingDifferences: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        var snapshot = Snapshot()
        snapshot.appendSections([.stories])
        snapshot.appendItems(stories, toSection: .stories)
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences, completion: completion)
    }
}

// MARK: - UICollectionViewDelegate

extension StoryTransitionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedStoryCell = collectionView.cellForItem(at: indexPath) as? StoryCollectionViewCell
        
        let viewController = StoryViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .custom
        navigationController.transitioningDelegate = self
        self.navigationController?.present(navigationController, animated: true)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension StoryTransitionViewController: UIViewControllerTransitioningDelegate {
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        let animator = StoryCircularPresentationAnimator(originPoint: originPointForAnimation)
        return animator
    }
    
    func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        let animator = StoryCircularDismissalAnimator(originPoint: originPointForAnimation)
        return animator
    }
}
