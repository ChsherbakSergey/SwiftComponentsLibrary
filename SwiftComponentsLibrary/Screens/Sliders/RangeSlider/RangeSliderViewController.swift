//  Created by Sergey Chsherbak on 15/04/2023.

import UIKit

final class RangeSliderViewController: UIViewController {
    
    // MARK: - Properties

    private let contentView = RangeSliderContentView()

    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Range Slider"
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
        setupTargets()
    }
    
    // MARK: - Setup
    
    private func setupTargets() {}
    
    // MARK: - Actions
}
