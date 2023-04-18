//  Created by Sergey Chsherbak on 15/04/2023.

import Components
import UIKit

final class RangeSliderContentView: UIView {
    
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
    
    let rangeSlider: RangeSlider = {
        let this = RangeSlider()
        this.translatesAutoresizingMaskIntoConstraints = false
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
        containerView.addSubview(rangeSlider)
//        containerView.addSubview(verticalStackView)
        scrollView.addSubview(containerView)
        addSubview(scrollView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            rangeSlider.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            rangeSlider.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            rangeSlider.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            rangeSlider.heightAnchor.constraint(equalToConstant: 32),

//            verticalStackView.topAnchor.constraint(equalTo: rangeSlider.bottomAnchor, constant: 32),
//            verticalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
//            verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
//            verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
//
//            setProgressButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
