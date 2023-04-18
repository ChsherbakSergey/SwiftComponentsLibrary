//  Created by Sergey Chsherbak on 18/04/2023.

import UIKit

final class CarouselCollectionViewFlowLayout: UICollectionViewFlowLayout {

    // MARK: - Public properties
    
    public var standardItemScale: CGFloat
    public var standardItemAlpha: CGFloat
    public var spacing: CGFloat
    public var baseSelectedForegroundColor: UIColor
    public var baseUnselectedForegroundColor: UIColor

    // MARK: - Overriden properties
    
    override class var layoutAttributesClass: AnyClass {
        return CarouselPickerViewLayoutAttributes.self
    }
    
    // MARK: - Init
    
    init(
        standardItemScale: CGFloat = 0.65,
        standardItemAlpha: CGFloat = 0.5,
        spacing: CGFloat = 40,
        baseSelectedForegroundColor: UIColor = .systemBlue,
        baseUnselectedForegroundColor: UIColor = .systemGray4
    ) {
        self.standardItemScale = standardItemScale
        self.standardItemAlpha = standardItemAlpha
        self.spacing = spacing
        self.baseSelectedForegroundColor = baseSelectedForegroundColor
        self.baseUnselectedForegroundColor = baseUnselectedForegroundColor
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overriden methods
    
    override func prepare() {
        super.prepare()
        setupCollectionView()
        updateLayout()
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
            let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
        else {
            return nil
        }

        guard let transformedAttributes = attributes
                .map({ transformLayoutAttributes($0) }) as? [CarouselPickerViewLayoutAttributes]
        else {
            return attributes
        }

        let updatedLayoutAttributes = updateBackgroundColor(forLayoutAttributes: transformedAttributes)
        return updatedLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return CarouselPickerViewLayoutAttributes.init(forCellWith: indexPath)
    }

    override func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint
    ) -> CGPoint {
        guard let collectionView = collectionView,
              !collectionView.isPagingEnabled,
              let layoutAttributes = layoutAttributesForElements(in: collectionView.bounds)
        else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        }

        let midSide = collectionView.bounds.size.width / 2
        let proposedContentOffsetCenterOrigin = proposedContentOffset.x + midSide
        let closest = layoutAttributes
            .sorted {
                abs($0.center.x - proposedContentOffsetCenterOrigin)
                < abs($1.center.x - proposedContentOffsetCenterOrigin)
            }
            .first ?? UICollectionViewLayoutAttributes()
        let targetContentOffset = CGPoint(
            x: floor(closest.center.x - midSide),
            y: proposedContentOffset.y
        )
        return targetContentOffset
    }

    // MARK: - Private methods
    
    private func setupCollectionView() {
        guard let collectionView = collectionView else { return }

        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
    }

    private func updateLayout() {
        guard let collectionView = collectionView else { return }

        let collectionViewSize = collectionView.bounds.size
        let yInset = (collectionViewSize.height - itemSize.height) / 2
        let xInset = (collectionViewSize.width - itemSize.width) / 2
        let side = itemSize.width
        let scaledItemOffset = (side - side * standardItemScale) / 2

        sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)
        minimumLineSpacing = spacing - scaledItemOffset
    }

    private func transformLayoutAttributes(
        _ attributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
        guard let collectionView = collectionView,
            let attributes = attributes as? CarouselPickerViewLayoutAttributes
        else {
            return attributes
        }

        let collectionViewCenter = collectionView.frame.size.width / 2
        let offset = collectionView.contentOffset.x
        let normalizedCenter = attributes.center.x - offset
        let maxDistance = itemSize.width + minimumLineSpacing
        let distance = min(abs(collectionViewCenter - normalizedCenter), maxDistance)
        let ratio = (maxDistance - distance) / maxDistance
        let alpha = ratio * (1 - standardItemAlpha) + standardItemAlpha
        let scale = ratio * (1 - standardItemScale) + standardItemScale

        attributes.alpha = alpha
        attributes.frame.origin.y = itemSize.height - (itemSize.height * scale)
        attributes.frame.size.height = itemSize.height * scale
        return attributes
    }

    private func updateBackgroundColor(
        forLayoutAttributes layoutAttributes: [CarouselPickerViewLayoutAttributes]
    ) -> [CarouselPickerViewLayoutAttributes] {
        let selectedLayoutAttribute = layoutAttributes
            .sorted { $0.frame.size.height > $1.frame.size.height }
            .first

        guard let selectedLayoutAttribute = selectedLayoutAttribute else { return layoutAttributes }

        for layoutAttribute in layoutAttributes {
            if layoutAttribute.indexPath.item <= selectedLayoutAttribute.indexPath.item {
                layoutAttribute.backgroundColor = baseSelectedForegroundColor
            } else {
                layoutAttribute.backgroundColor = baseUnselectedForegroundColor
            }
        }
        return layoutAttributes
    }
}
