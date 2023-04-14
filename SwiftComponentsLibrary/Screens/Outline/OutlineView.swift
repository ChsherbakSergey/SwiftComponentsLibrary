//  Created by Sergey Chsherbak on 14/04/2023.

import UIKit

final class OutlineView: UIView {

    // MARK: - UI Elements

    lazy var collectionView: UICollectionView = {
        let layout = createCollectionViewLayout()
        let this = UICollectionView(frame: .zero, collectionViewLayout: layout)
        this.translatesAutoresizingMaskIntoConstraints = false
        this.showsVerticalScrollIndicator = false
        return this
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupView() {
        backgroundColor = .systemBackground
    }

    private func setupSubviews() {
        addSubview(collectionView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func createCollectionViewLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            let section = OutlineViewController.Section(rawValue: sectionIndex)
            switch section {
            case .main:
                return self?.makeMainSectionLayout(with: layoutEnvironment)
            default:
                return nil
            }
        }
    }

    private func makeMainSectionLayout(with layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.headerTopPadding = 24
        let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
        return section
    }
}
