//  Created by Sergey Chsherbak on 13/05/2023.

import UIKit

public protocol SlideButtonDelegate: AnyObject {
    func didFinishSliding()
}

public final class SlideButton: UIView {
    
    // MARK: - UI Elements
    
    private let containerView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.layer.cornerCurve = .continuous
        this.layer.cornerRadius = 26
        return this
    }()
    
    private let handleView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.layer.cornerRadius = 22
        return this
    }()
    
    private let handleImageView: UIImageView = {
        let this = UIImageView(image: UIImage(systemName: "arrow.forward"))
        this.translatesAutoresizingMaskIntoConstraints = false
        this.contentMode = .scaleAspectFit
        return this
    }()
    
    private let handleActivityIndicatorView: UIActivityIndicatorView = {
        let this = UIActivityIndicatorView(style: .medium)
        this.translatesAutoresizingMaskIntoConstraints = false
        this.hidesWhenStopped = true
        this.isHidden = true
        this.alpha = 0
        this.color = .systemGray
        return this
    }()
    
    private let draggedView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.layer.cornerRadius = 22
        return this
    }()
    
    private let titleLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.textAlignment = .center
        this.textColor = .white
        this.font = .systemFont(ofSize: 15, weight: .medium)
        return this
    }()
    
    // MARK: - Public Properties
    
    public var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var baseBackgroundColor: UIColor = .systemBlue {
        didSet {
            containerView.backgroundColor = baseBackgroundColor
        }
    }
    
    public var handleBaseBackgroundColor: UIColor = .white {
        didSet {
            handleView.backgroundColor = handleBaseBackgroundColor
            draggedView.backgroundColor = handleBaseBackgroundColor
        }
    }
    
    public var handleBaseForegroundColor: UIColor = .systemBlue {
        didSet {
            handleImageView.tintColor = handleBaseForegroundColor
        }
    }
    
    public weak var delegate: SlideButtonDelegate?
    
    // MARK: - Private Properties
    
    private var leadingHandleViewConstraint: NSLayoutConstraint!
    
    private var xEndingPoint: CGFloat {
        return bounds.width - handleView.bounds.width - 4
    }
    
    private var isFinished = false
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupSubviews()
        setupLayout()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func finish() {
        handleImageView.image = UIImage(systemName: "checkmark")
        UIView.animate(withDuration: 0.23) { [weak self] in
            self?.handleActivityIndicatorView.stopAnimating()
            self?.handleImageView.alpha = 1
        } completion: { [weak self] _ in
            self?.handleActivityIndicatorView.stopAnimating()
            self?.handleActivityIndicatorView.isHidden = true
        }
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .systemBackground
        containerView.backgroundColor = baseBackgroundColor
        handleView.backgroundColor = handleBaseBackgroundColor
        draggedView.backgroundColor = handleBaseBackgroundColor
    }
    
    private func setupSubviews() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(draggedView)
        containerView.addSubview(handleView)
        handleView.addSubview(handleImageView)
        handleView.addSubview(handleActivityIndicatorView)
    }
    
    private func setupLayout() {
        leadingHandleViewConstraint = handleView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 52),
            
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            handleView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            leadingHandleViewConstraint,
            handleView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
            handleView.widthAnchor.constraint(equalToConstant: 44),
            
            handleImageView.centerYAnchor.constraint(equalTo: handleView.centerYAnchor),
            handleImageView.centerXAnchor.constraint(equalTo: handleView.centerXAnchor),
            
            handleActivityIndicatorView.centerYAnchor.constraint(equalTo: handleView.centerYAnchor),
            handleActivityIndicatorView.centerXAnchor.constraint(equalTo: handleView.centerXAnchor),
            
            draggedView.topAnchor.constraint(equalTo: handleView.topAnchor),
            draggedView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            draggedView.trailingAnchor.constraint(equalTo: handleView.trailingAnchor),
            draggedView.bottomAnchor.constraint(equalTo: handleView.bottomAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupGestures() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGestureRecognizer.minimumNumberOfTouches = 1
        handleView.addGestureRecognizer(panGestureRecognizer)
    }
    
    // MARK: - Actions
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translationX = gesture.translation(in: self).x
        switch gesture.state {
        case .changed:
            if translationX <= 4 {
                updateHandleViewXPosition(to: 4)
            } else if translationX >= xEndingPoint {
                updateHandleViewXPosition(to: xEndingPoint)
            } else {
                updateHandleViewXPosition(to: translationX)
            }
            let textLabelAlpha = 1 - (translationX / bounds.width * 2)
            setTextLabelAlpha(to: textLabelAlpha)
        case .ended:
            if translationX >= xEndingPoint {
                self.updateHandleViewXPosition(to: xEndingPoint)
                isFinished = true
                delegate?.didFinishSliding()
                load()
            } else {
                reset()
                UIView.animate(withDuration: 0.23) { [weak self] in
                    self?.setTextLabelAlpha(to: 1)
                    self?.layoutIfNeeded()
                }
            }
        default:
            break
        }
    }
    
    // MARK: - Helpers
    
    private func updateHandleViewXPosition(to x: CGFloat) {
        leadingHandleViewConstraint.constant = x
    }

    private func reset() {
        isFinished = false
        updateHandleViewXPosition(to: 4)
    }
    
    private func setTextLabelAlpha(to value: CGFloat) {
        titleLabel.alpha = value
    }
    
    private func load() {
        handleActivityIndicatorView.isHidden = false
        handleActivityIndicatorView.startAnimating()
        UIView.animate(withDuration: 0.23) { [weak self] in
            self?.handleImageView.alpha = 0
            self?.handleActivityIndicatorView.alpha = 1
        }
    }
}
