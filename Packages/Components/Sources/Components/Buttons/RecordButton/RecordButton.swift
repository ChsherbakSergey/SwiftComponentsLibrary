//  Created by Sergey Chsherbak on 30/04/2023.

import UIKit

public final class RecordButton: UIControl {
    
    // MARK: - UI Elements
    
    private let borderView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.backgroundColor = .clear
        this.layer.cornerRadius = 34
        this.layer.borderWidth = 4
        this.layer.shadowColor = UIColor.black.cgColor
        this.layer.shadowOpacity = 0.10
        this.layer.shadowOffset = .zero
        this.layer.shadowRadius = 4
        return this
    }()
    
    private let button: TappableButton = {
        let this = TappableButton(type: .system)
        this.translatesAutoresizingMaskIntoConstraints = false
        this.layer.cornerRadius = 28
        return this
    }()
    
    // MARK: - Public Properties
    
    public var borderColor: UIColor = .white {
        didSet {
            borderView.layer.borderColor = borderColor.cgColor
            setNeedsDisplay()
        }
    }
    
    public var foregroundColor: UIColor = .systemRed {
        didSet {
            button.backgroundColor = foregroundColor
            setNeedsDisplay()
        }
    }
    
    // MARK: - Private Properties

    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
    private var stateAnimator: UIViewPropertyAnimator?
    
    private var buttonWidthConstraint: NSLayoutConstraint!
    private var buttonHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupSubviews()
        setupLayout()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func startRecording() {
        buttonWidthConstraint.constant = 24
        buttonHeightConstraint.constant = 24
        
        UIView.animate(
            withDuration: 0.23,
            delay: .zero,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut) { [weak self] in
                guard let self else { return }
                
                self.button.layer.cornerRadius = 4
                self.button.touchPadding = 44
                self.button.layoutIfNeeded()
            }
    }
    
    public func stopRecording() {
        buttonWidthConstraint.constant = 56
        buttonHeightConstraint.constant = 56
        
        UIView.animate(
            withDuration: 0.23,
            delay: .zero,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut) { [weak self] in
                guard let self else { return }
                
                self.button.layer.cornerRadius = 30
                self.button.touchPadding = 0
                self.button.layoutIfNeeded()
            }
    }
    
    // MARK: - Setup
    
    private func setup() {
        backgroundColor = .clear
        borderView.layer.borderColor = borderColor.cgColor
        button.backgroundColor = foregroundColor
    }
    
    private func setupSubviews() {
        addSubview(borderView)
        addSubview(button)
    }
    
    private func setupLayout() {
        buttonWidthConstraint = button.widthAnchor.constraint(equalToConstant: 56)
        buttonHeightConstraint = button.heightAnchor.constraint(equalToConstant: 56)
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 68),
            heightAnchor.constraint(equalToConstant: 68),
            
            borderView.centerYAnchor.constraint(equalTo: centerYAnchor),
            borderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            borderView.widthAnchor.constraint(equalToConstant: 68),
            borderView.heightAnchor.constraint(equalToConstant: 68),
            
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonWidthConstraint,
            buttonHeightConstraint
        ])
    }
    
    private func setupTargets() {
        button.addTarget(self, action: #selector(didTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
        button.addTarget(self, action: #selector(didTouchUpOutside), for: .touchUpOutside)
        button.addTarget(self, action: #selector(touchDidCancel), for: .touchCancel)
    }
    
    // MARK: - Actions
    
    @objc private func didTouchDown() {
        update(state: .highlighted)
    }
    
    @objc private func didTouchUpInside() {
        update(state: .normal)
        triggerTouchOccured()
    }
    
    @objc private func didTouchUpOutside() {
        update(state: .normal)
    }

    @objc private func touchDidCancel() {
        update(state: .normal)
    }
    
    // MARK: - Helper Methods
    
    private func update(state: State) {
        self.stateAnimator?.stopAnimation(true)
        self.stateAnimator = UIViewPropertyAnimator(duration: 0.23, curve: .easeOut) { [weak self] in
            guard let self else { return }
            switch state {
            case .normal:
                self.button.transform = .identity
            case .highlighted:
                self.button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }
        }
        self.stateAnimator?.startAnimation()
    }
    
    private func triggerTouchOccured() {
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
        sendActions(for: .touchUpInside)
    }
}

extension RecordButton {
    enum State {
        case normal
        case highlighted
    }
}

fileprivate final class TappableButton: UIButton {
    
    // MARK: - Properties
    
    /// The area around button's bounds which reacts to its touches as if they would be placed inside button's bounds.
    public var touchPadding: CGFloat = 0 {
        didSet {
            touchPadding = max(touchPadding, 0)
        }
    }
    
    // MARK: - Overriden methods
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let newArea = bounds.insetBy(dx: -touchPadding, dy: -touchPadding)
        return newArea.contains(point)
    }
}
