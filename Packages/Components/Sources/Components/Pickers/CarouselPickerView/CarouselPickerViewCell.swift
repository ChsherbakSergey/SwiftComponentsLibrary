//  Created by Sergey Chsherbak on 18/04/2023.

import UIKit

final class CarouselPickerViewCell: UICollectionViewCell {

    // MARK: - Overriden methods
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        guard let attributes = layoutAttributes as? CarouselPickerViewLayoutAttributes else { return }

        UIView.animate(withDuration: 0.23) { [weak self] in
            self?.backgroundColor = attributes.backgroundColor
        }
    }
}
