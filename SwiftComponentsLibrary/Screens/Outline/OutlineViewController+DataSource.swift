//  Created by Sergey Chsherbak on 14/04/2023.

import UIKit

extension OutlineViewController {
    enum Section: Int, CaseIterable {
        case main
    }

    final class OutlineItem: Identifiable, Hashable {
        let id = UUID()
        let title: String
        let subitems: [OutlineItem]
        let viewController: UIViewController.Type?
        let presentation: Presentation

        enum Presentation {
            case present
            case push
        }

        init(
            title: String,
            subitems: [OutlineItem] = [],
            viewController: UIViewController.Type? = nil,
            presentation: Presentation = .push
        ) {
            self.title = title
            self.subitems = subitems
            self.viewController = viewController
            self.presentation = presentation
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

        static func ==(lhs: OutlineItem, rhs: OutlineItem) -> Bool {
            return lhs.id == rhs.id
        }
    }
}

extension OutlineViewController {
    final class ItemData {
        let menuItems = [
            OutlineItem(
                title: "Activity Indicators",
                subitems: [
                    OutlineItem(
                        title: "Growing Circle Activity Indicator View",
                        viewController: GrowingCircleActivityIndicatorViewController.self
                    )
                ]
            ),
            OutlineItem(
                title: "Buttons",
                subitems: [
                    OutlineItem(
                        title: "3D Button",
                        viewController: Button3DViewController.self
                    )
                ]
            ),
            OutlineItem(
                title: "Pickers",
                subitems: [
                    OutlineItem(
                        title: "Carousel Picker View",
                        viewController: CarouselPickerViewController.self
                    )
                ]
            ),
            OutlineItem(
                title: "Progresses",
                subitems: [
                    OutlineItem(
                        title: "Circle Progress View",
                        viewController: CircleProgressViewController.self
                    ),
                    OutlineItem(
                        title: "Progress Bar View",
                        viewController: ProgressBarViewController.self
                    ),
                    OutlineItem(
                        title: "Stroke Progress Bar View",
                        viewController: StrokeProgressBarViewController.self
                    )
                ]
            ),
            OutlineItem(
                title: "Selectors",
                subitems: [
                    OutlineItem(
                        title: "Color Selector View",
                        viewController: ColorSelectorViewController.self
                    )
                ]
            ),
            OutlineItem(
                title: "Sliders",
                subitems: [
                    OutlineItem(
                        title: "Range Slider",
                        viewController: RangeSliderViewController.self
                    )
                ]
            ),
            OutlineItem(
                title: "Toasts",
                subitems: [
                    OutlineItem(
                        title: "Toast View",
                        viewController: ToastViewController.self
                    )
                ]
            )
        ]
    }
}

extension OutlineViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, OutlineItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, OutlineItem>
    typealias SectionSnapshot = NSDiffableDataSourceSectionSnapshot<OutlineItem>
}
