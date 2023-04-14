//  Created by Sergey Chsherbak on 14/04/2023.

public final class Toaster {
    
    // MARK: - Properties

    public static let shared = Toaster()

    private var currentlyPresentedViewController: ToastViewController?

    // MARK: - Init
    
    private init() {}
    
    // MARK: - Public Methods

    public func show(
        with configuration: ToastConfiguration,
        model: ToastView.Model
    ) {
        currentlyPresentedViewController?.hideIfNeeded()

        let toastViewController = ToastViewController(
            configuration: configuration,
            model: model
        )
        currentlyPresentedViewController = toastViewController
        toastViewController.show()
    }
}
