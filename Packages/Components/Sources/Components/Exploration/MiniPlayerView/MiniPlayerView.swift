//  Created by Sergey Chsherbak on 06/05/2023.

import UIKit

public final class MiniPlayerView: UIView {
    
    // MARK: - UI Elements
    
    private let containerView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        return this
    }()
    
    private let blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .systemUltraThinMaterial)
        let this = UIVisualEffectView(effect: effect)
        this.translatesAutoresizingMaskIntoConstraints = false
        return this
    }()
    
    private let separatorView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.backgroundColor = .systemGray
        return this
    }()
    
    private let previewView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.backgroundColor = .systemYellow
        this.layer.cornerRadius = 4
        return this
    }()
    
    private let titleLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = .systemFont(ofSize: 16)
        return this
    }()
    
    private let subtitleLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = .systemFont(ofSize: 13)
        this.textColor = .secondaryLabel
        return this
    }()
    
    private let labelsStackView: UIStackView = {
        let this = UIStackView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.axis = .vertical
        this.spacing = 4
        return this
    }()
    
    public let playButton: UIButton = {
        let this = UIButton(type: .system)
        this.translatesAutoresizingMaskIntoConstraints = false
        this.setImage(UIImage(systemName: "play.fill"), for: .normal)
        this.tintColor = .label
        return this
    }()
    
    public let pauseButton: UIButton = {
        let this = UIButton(type: .system)
        this.translatesAutoresizingMaskIntoConstraints = false
        this.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        this.tintColor = .label
        this.alpha = 0
        this.transform = CGAffineTransform(scaleX: 0, y: 0)
        return this
    }()
    
    public let forwardButton: UIButton = {
        let this = UIButton(type: .system)
        this.translatesAutoresizingMaskIntoConstraints = false
        this.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        this.tintColor = .label
        return this
    }()
    
    // MARK: - Private Properties
    
    private var animator: UIViewPropertyAnimator?
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    /// Configures the player view with the provided model. Substitute the model with whatever fits your requirements.
    /// - Parameter model: The model which includes parameters needed to setup the player view.
    public func configure(with model: MiniPlayerView.Song) {
        previewView.backgroundColor = model.previewColor
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }
    
    public func play() {
        // Execute whatever logic you might need.
        
        animator?.stopAnimation(true)
        animator = UIViewPropertyAnimator(duration: 0.23, curve: .easeOut) { [weak self] in
            self?.playButton.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            self?.playButton.alpha = 0
            self?.pauseButton.transform = .identity
            self?.pauseButton.alpha = 1
        }
        animator?.startAnimation()
    }
    
    public func pause() {
        // Execute whatever logic you might need.
        
        animator?.stopAnimation(true)
        animator = UIViewPropertyAnimator(duration: 0.23, curve: .easeOut) { [weak self] in
            self?.pauseButton.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            self?.pauseButton.alpha = 0
            self?.playButton.transform = .identity
            self?.playButton.alpha = 1
        }
        animator?.startAnimation()
    }
    
    public func next() {
        // Execute whatever logic you might need.
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        addSubview(containerView)
        addSubview(separatorView)
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(subtitleLabel)
        containerView.addSubview(blurView)
        containerView.addSubview(previewView)
        containerView.addSubview(labelsStackView)
        containerView.addSubview(playButton)
        containerView.addSubview(pauseButton)
        containerView.addSubview(forwardButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 64),
            
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -0.5),
            
            separatorView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            blurView.topAnchor.constraint(equalTo: containerView.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            previewView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            previewView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            previewView.widthAnchor.constraint(equalToConstant: 48),
            previewView.heightAnchor.constraint(equalToConstant: 48),
            
            labelsStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: previewView.trailingAnchor, constant: 12),
            labelsStackView.trailingAnchor.constraint(lessThanOrEqualTo: playButton.trailingAnchor, constant: -36),
            
            playButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            playButton.trailingAnchor.constraint(equalTo: forwardButton.leadingAnchor, constant: -24),
            
            pauseButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            pauseButton.trailingAnchor.constraint(equalTo: forwardButton.leadingAnchor, constant: -24),
            
            forwardButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            forwardButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }
}

public extension MiniPlayerView {
    
    struct Song {
        let previewColor: UIColor
        let title: String
        let subtitle: String
        
        public init(previewColor: UIColor, title: String, subtitle: String) {
            self.previewColor = previewColor
            self.title = title
            self.subtitle = subtitle
        }
    }
}
