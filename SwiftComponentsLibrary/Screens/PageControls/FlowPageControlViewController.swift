//  Created by Sergey Chsherbak on 18/04/2023.

import UIKit

final class FlowPageControlViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = FlowPageControlContentView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
}
