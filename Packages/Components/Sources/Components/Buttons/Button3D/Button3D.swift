//  Created by Sergey Chsherbak on 20/04/2023.

import UIKit

public final class Button3D: UIControl {
    
    // MARK: - UI Elements
    
    private let backgroundView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        return this
    }()
    
    private let button: UIButton = {
        let this = UIButton(type: .system)
        this.translatesAutoresizingMaskIntoConstraints = false
        return this
    }()
    
    private let titleLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = .systemFont(ofSize: 15, weight: .semibold)
        this.textColor = .white
        this.textAlignment = .center
        this.numberOfLines = 1
        return this
    }()
    
    // MARK: - Public Properties
    
    public var title: String = "" {
        didSet {
            titleLabel.text = title
            setNeedsDisplay()
        }
    }
    
    public var baseBackgroundColor: UIColor = UIColor(red: 52/255, green: 149/255, blue: 89/255, alpha: 1) {
        didSet {
            backgroundView.backgroundColor = baseBackgroundColor
            setNeedsDisplay()
        }
    }
    
    public var baseForegroundColor: UIColor = UIColor(red: 52/255, green: 199/255, blue: 89/255, alpha: 1) {
        didSet {
            button.backgroundColor = baseForegroundColor
            setNeedsDisplay()
        }
    }
    
    public var cornerRadius: CGFloat = 0 {
        didSet {
            backgroundView.layer.cornerRadius = cornerRadius
            button.layer.cornerRadius = cornerRadius
            setNeedsDisplay()
        }
    }
    
    // MARK: - Private Properties
    
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupSubviews()
        setupLayout()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setup() {
        titleLabel.text = title
        backgroundView.backgroundColor = baseBackgroundColor
        button.backgroundColor = baseForegroundColor
        backgroundView.layer.cornerRadius = cornerRadius
        button.layer.cornerRadius = cornerRadius
        update(state: .normal)
    }
    
    private func setupSubviews() {
        addSubview(backgroundView)
        addSubview(button)
        button.addSubview(titleLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            button.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: -4),
            button.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -4),
            
            titleLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -16)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
            self.update(state: .normal)
            self.triggerTouchOccured()
        }
    }
    
    @objc private func didTouchUpOutside() {
        update(state: .normal)
    }

    @objc private func touchDidCancel() {
        update(state: .normal)
    }
    
    // MARK: - Helper Methods
    
    private func update(state: State) {
        switch state {
        case .normal:
            button.transform = .identity
        case .highlighted:
            button.transform = CGAffineTransform(translationX: 0, y: 4)
        }
    }

    private func triggerTouchOccured() {
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
        sendActions(for: .touchUpInside)
    }
}

extension Button3D {
    enum State {
        case normal
        case highlighted
    }
}
