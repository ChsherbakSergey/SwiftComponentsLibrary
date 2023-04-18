//  Created by Sergey Chsherbak on 18/04/2023.

import UIKit

final class CarouselPickerViewLayoutAttributes: UICollectionViewLayoutAttributes {

    // MARK: - Properties
    
    var backgroundColor = UIColor.systemGray4

    // MARK: - Overriden methods
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! CarouselPickerViewLayoutAttributes
        copy.backgroundColor = backgroundColor
        return copy
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let rhs = object as? CarouselPickerViewLayoutAttributes else { return false }

        if backgroundColor != rhs.backgroundColor {
            return false
        }
        return super.isEqual(object)
    }
}
