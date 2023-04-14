//  Created by Sergey Chsherbak on 14/04/2023.

import UIKit

final class OutlineViewController: UIViewController {

    // MARK: - Properties

    private let contentView = OutlineView()
    private let itemData = ItemData()

    private lazy var dataSource = createDataSource()

    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Components Library"
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
        setupDelegates()
        applySnapshot(animatingDifferences: false)
    }

    // MARK: - Setup

    private func setupDelegates() {
        contentView.collectionView.delegate = self
    }
}

// MARK: - DataSource

private extension OutlineViewController {

    func createDataSource() -> DataSource {
        let itemCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, OutlineItem> { cell, indexPath, item in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = item.title
            contentConfiguration.textProperties.font = .preferredFont(forTextStyle: .headline)
            cell.contentConfiguration = contentConfiguration

            let outlineDisclosureOptions = UICellAccessory.OutlineDisclosureOptions(style: .header)
            cell.accessories = [.outlineDisclosure(options: outlineDisclosureOptions)]
            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
        }

        let subitemCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, OutlineItem> {
            (cell, indexPath, item) in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = item.title
            cell.contentConfiguration = contentConfiguration
            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
        }

        let dataSource = DataSource(collectionView: contentView.collectionView) { collectionView, indexPath, item in
            if item.subitems.isEmpty {
                let cell = collectionView.dequeueConfiguredReusableCell(using: subitemCellRegistration, for: indexPath, item: item)
                return cell
            } else {
                let cell = collectionView.dequeueConfiguredReusableCell(using: itemCellRegistration, for: indexPath, item: item)
                return cell
            }
        }

        return dataSource
    }

    func applySnapshot(animatingDifferences: Bool) {
        var snapshot = SectionSnapshot()

        func addItems(_ menuItems: [OutlineItem], to parent: OutlineItem?) {
            snapshot.append(menuItems, to: parent)
            for menuItem in menuItems where !menuItem.subitems.isEmpty {
                addItems(menuItem.subitems, to: menuItem)
            }
        }

        addItems(itemData.menuItems, to: nil)
        dataSource.apply(snapshot, to: .main, animatingDifferences: animatingDifferences)
    }
}

// MARK: - UICollectionViewDelegate

extension OutlineViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let menuItem = dataSource.itemIdentifier(for: indexPath) else {
            collectionView.deselectItem(at: indexPath, animated: true)
            return
        }

        if let viewController = menuItem.viewController {
            switch menuItem.presentation {
            case .present:
                let navigationController = UINavigationController(rootViewController: viewController.init())
                self.navigationController?.present(navigationController, animated: true)
            case .push:
                navigationController?.pushViewController(viewController.init(), animated: true)
            }
        }

        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
