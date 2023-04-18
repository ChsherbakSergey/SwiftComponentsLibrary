//  Created by Sergey Chsherbak on 14/04/2023.

import UIKit

public final class ToastViewController: UIViewController {

    // MARK: - Public Properties

    public let configuration: ToastConfiguration
    public let model: ToastView.Model

    // MARK: - Private Properties

    private let generator = UINotificationFeedbackGenerator()
    private var window: UIWindow?
    private var hideAnimator: UIViewPropertyAnimator?
    private var animationProgressWhenInterrupted: CGFloat = 0

    private lazy var toastView: ToastView = {
        let this = ToastView()
        this.translatesAutoresizingMaskIntoConstraints = false
        return this
    }()

    // MARK: - Initialization

    public init(
        configuration: ToastConfiguration,
        model: ToastView.Model
    ) {
        self.configuration = configuration
        self.model = model
        super.init(nibName: nil, bundle: nil)
        installWindow()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Lifecycle

    public override func loadView() {
        view = PassthroughView()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }

    // MARK: - Internal Methods

    func show() {
        window?.isHidden = false
        view.layoutIfNeeded()

        let toastViewHeight = toastView.bounds.size.height
        var yTranslation: CGFloat?

        switch configuration.animationType {
        case .top:
            yTranslation = toastViewHeight + (UIApplication.shared.topPaddingToSafeArea ?? 0)
        }

        let animator = UIViewPropertyAnimator(
            duration: configuration.animationDuration,
            curve: .easeInOut
        ) { [weak self] in
            guard let self else { return }

            switch self.configuration.animationType {
            case .top:
                self.toastView.transform = CGAffineTransform(translationX: 0, y: yTranslation ?? 0)
            }
        }
        animator.startAnimation()
        generateFeedback()
        makeHideAnimator()

        if configuration.isAutohidable {
            let delay = configuration.animationDuration + configuration.displayDuration
            hideAnimator?.startAnimation(afterDelay: delay)
        }
    }

    func hideIfNeeded() {
        guard let hideAnimator = hideAnimator else { return }

        let timing = UICubicTimingParameters(animationCurve: .easeInOut)
        hideAnimator.pauseAnimation()
        hideAnimator.continueAnimation(withTimingParameters: timing, durationFactor: 0)
    }

    // MARK: - Private Methods

    private func installWindow() {
        if let windowScene = UIApplication.shared.windowScene {
            window = PassthroughWindow(windowScene: windowScene)
        }
        window?.windowLevel = .statusBar
        window?.rootViewController = self
    }

    private func setupView() {
        toastView.configure(with: model)
        if configuration.isUserInteractionEnabled {
            let panGestureRecognizer = UIPanGestureRecognizer(
                target: self,
                action: #selector(onPan(_:))
            )
            view.addGestureRecognizer(panGestureRecognizer)
        }
        view.addSubview(toastView)
    }

    private func setupLayout() {
        switch configuration.animationType {
        case .top:
            NSLayoutConstraint.activate([
                toastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                toastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                toastView.bottomAnchor.constraint(equalTo: view.topAnchor)
            ])
        }
    }

    private func generateFeedback() {
        generator.prepare()
        switch model.type {
        case .error:
            generator.notificationOccurred(.error)
        case .warning:
            generator.notificationOccurred(.warning)
        case .success:
            generator.notificationOccurred(.success)
        }
    }

    private func makeHideAnimator() {
        hideAnimator = UIViewPropertyAnimator(duration: configuration.animationDuration, curve: .easeInOut) { [weak self] in
            guard let self else { return }

            switch self.configuration.animationType {
            case .top:
                self.toastView.transform = .identity
            }
        }
        hideAnimator?.addCompletion { [weak self] _ in
            self?.toastView.removeFromSuperview()
            self?.window?.isHidden = true
            self?.window = nil
        }
    }

    // MARK: - Actions

    @objc private func onPan(_ gestureRecognizer: UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began:
            hideAnimator?.pauseAnimation()
            animationProgressWhenInterrupted = hideAnimator?.fractionComplete ?? 0
        case .changed:
            let toastViewHeight = toastView.bounds.size.height
            var yTranslation: CGFloat?

            switch configuration.animationType {
            case .top:
                yTranslation = toastViewHeight + (UIApplication.shared.topPaddingToSafeArea ?? 0)
            }

            let translation = gestureRecognizer.translation(in: toastView)
            let fractionComplete = (-translation.y / (yTranslation ?? 0)) + animationProgressWhenInterrupted
            hideAnimator?.fractionComplete = fractionComplete
        case .ended:
            let timing = UICubicTimingParameters(animationCurve: .easeInOut)
            hideAnimator?.continueAnimation(withTimingParameters: timing, durationFactor: 0)
        case .possible, .cancelled, .failed:
            break
        @unknown default:
            fatalError("Handle a new pan gesture's state case.")
        }
    }
}

fileprivate extension ToastViewController {
    
    final class PassthroughView: UIView {
        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            let view = super.hitTest(point, with: event)
            return view == self ? nil : view
        }
    }

    final class PassthroughWindow: UIWindow {
        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            let view = super.hitTest(point, with: event)
            return view == self ? nil : view
        }
    }
}

fileprivate extension UIApplication {
    
    var windowScene: UIWindowScene? {
        return connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first as? UIWindowScene
    }
    
    var topPaddingToSafeArea: CGFloat? {
        return UIApplication.shared
            .connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)?
            .safeAreaInsets
            .top
    }
}
