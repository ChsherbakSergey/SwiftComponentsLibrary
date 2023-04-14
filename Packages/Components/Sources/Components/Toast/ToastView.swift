//  Created by Sergey Chsherbak on 14/04/2023.

import UIKit

public final class ToastView: UIView {
    
    // MARK: - UI Elements

    private let imageView: UIImageView = {
        let this = UIImageView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.contentMode = .scaleAspectFit
        return this
    }()

    private let titleLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = .systemFont(ofSize: 15, weight: .semibold)
        this.textColor = .label
        this.numberOfLines = 1
        return this
    }()

    private let subtitleLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = .systemFont(ofSize: 13, weight: .medium)
        this.textColor = .systemGray
        this.numberOfLines = 0
        this.isHidden = true
        return this
    }()

    private let verticalStackView: UIStackView = {
        let this = UIStackView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.axis = .vertical
        this.spacing = 4
        return this
    }()
    
    private let blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .systemUltraThinMaterial)
        let this = UIVisualEffectView(effect: effect)
        this.translatesAutoresizingMaskIntoConstraints = false
        return this
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupSubviews()
        setupLayout()
        setupShadow()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height > 60 ? 30 : bounds.height / 2
    }

    // MARK: - Configuration

    public func configure(with model: Model) {
        switch model.type {
        case .error:
            imageView.image = UIImage(systemName: "exclamationmark.circle.fill")
            imageView.tintColor = .systemRed
        case .warning:
            imageView.image = UIImage(systemName: "exclamationmark.circle.fill")
            imageView.tintColor = .systemYellow
        case .success:
            imageView.image = UIImage(systemName: "checkmark.circle.fill")
            imageView.tintColor = .systemGreen
        }
        titleLabel.text = model.title
        if let subtitle = model.subtitle {
            subtitleLabel.isHidden = false
            subtitleLabel.text = subtitle
        }
    }

    // MARK: - Setup

    private func setupView() {
        backgroundColor = .systemBackground
        clipsToBounds = true
    }

    private func setupSubviews() {
        addSubview(blurView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleLabel)
        addSubview(imageView)
        addSubview(verticalStackView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            
            verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            verticalStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = .zero
        layer.shadowRadius = 8
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}

extension ToastView {
    
    public struct Model {
        let type: `Type`
        let title: String
        let subtitle: String?
        
        public enum `Type` {
            case error
            case warning
            case success
        }

        public init(
            type: `Type`,
            title: String,
            subtitle: String? = nil
        ) {
            self.type = type
            self.title = title
            self.subtitle = subtitle
        }
    }
}
