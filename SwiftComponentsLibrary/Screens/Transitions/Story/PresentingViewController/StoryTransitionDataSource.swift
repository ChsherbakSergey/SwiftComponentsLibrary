//  Created by Sergey Chsherbak on 21/02/2024.

import UIKit

extension StoryTransitionViewController {
    enum Section: Int, CaseIterable {
        case stories
    }
}

extension StoryTransitionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, UIColor>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, UIColor>
}
