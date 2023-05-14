//  Created by Sergey Chsherbak on 13/05/2023.

import Components
import UIKit

final class SlideButtonContentView: UIView {
    
    // MARK: - UI Elements
    
    private let scrollView: UIScrollView = {
        let this = UIScrollView()
        this.translatesAutoresizingMaskIntoConstraints = false
        return this
    }()

    private let containerView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        return this
    }()
    
    let titleTextLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Title Text:"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let titleTextSegmentedControl: UISegmentedControl = {
        let this = UISegmentedControl()
        this.insertSegment(withTitle: "Approve", at: 0, animated: false)
        this.insertSegment(withTitle: "Star the project", at: 1, animated: false)
        this.insertSegment(withTitle: "Slide to open", at: 2, animated: false)
        this.selectedSegmentIndex = 0
        return this
    }()

    private let titleTextStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()
    
    let baseBackgroundColorLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Background Color:"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let baseBackgroundColorSegmentedControl: UISegmentedControl = {
        let this = UISegmentedControl()
        this.insertSegment(withTitle: "System Blue", at: 0, animated: false)
        this.insertSegment(withTitle: "System Green", at: 1, animated: false)
        this.insertSegment(withTitle: "System Indigo", at: 2, animated: false)
        this.selectedSegmentIndex = 0
        return this
    }()

    private let baseBackgroundColorStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()
    
    let handleBaseBackgroundColorLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Handle Background Color:"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let handleBaseBackgroundColorSegmentedControl: UISegmentedControl = {
        let this = UISegmentedControl()
        this.insertSegment(withTitle: "White", at: 0, animated: false)
        this.insertSegment(withTitle: "Light Gray", at: 1, animated: false)
        this.selectedSegmentIndex = 0
        return this
    }()

    private let handleBaseBackgroundColorStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()
    
    let handleBaseForegroundColorLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.text = "Handle Foreground Color:"
        this.textColor = .label
        this.font = .systemFont(ofSize: 13, weight: .medium)
        return this
    }()

    let handleBaseForegroundColorSegmentedControl: UISegmentedControl = {
        let this = UISegmentedControl()
        this.insertSegment(withTitle: "System Blue", at: 0, animated: false)
        this.insertSegment(withTitle: "System Green", at: 1, animated: false)
        this.insertSegment(withTitle: "System Indigo", at: 2, animated: false)
        this.selectedSegmentIndex = 0
        return this
    }()

    private let handleBaseForegroundColorStackView: UIStackView = {
        let this = UIStackView()
        this.axis = .vertical
        this.spacing = 8
        return this
    }()
    
    private let verticalStackView: UIStackView = {
        let this = UIStackView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.axis = .vertical
        this.spacing = 16
        return this
    }()
    
    let button: SlideButton = {
        let this = SlideButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.title = "Approve"
        return this
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .systemBackground
    }

    private func setupSubviews() {
        titleTextStackView.addArrangedSubview(titleTextLabel)
        titleTextStackView.addArrangedSubview(titleTextSegmentedControl)
        baseBackgroundColorStackView.addArrangedSubview(baseBackgroundColorLabel)
        baseBackgroundColorStackView.addArrangedSubview(baseBackgroundColorSegmentedControl)
        handleBaseBackgroundColorStackView.addArrangedSubview(handleBaseBackgroundColorLabel)
        handleBaseBackgroundColorStackView.addArrangedSubview(handleBaseBackgroundColorSegmentedControl)
        handleBaseForegroundColorStackView.addArrangedSubview(handleBaseForegroundColorLabel)
        handleBaseForegroundColorStackView.addArrangedSubview(handleBaseForegroundColorSegmentedControl)
        verticalStackView.addArrangedSubview(titleTextStackView)
        verticalStackView.addArrangedSubview(baseBackgroundColorStackView)
        verticalStackView.addArrangedSubview(handleBaseBackgroundColorStackView)
        verticalStackView.addArrangedSubview(handleBaseForegroundColorStackView)
        containerView.addSubview(verticalStackView)
        scrollView.addSubview(containerView)
        addSubview(scrollView)
        addSubview(button)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -92),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            verticalStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            verticalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
}
