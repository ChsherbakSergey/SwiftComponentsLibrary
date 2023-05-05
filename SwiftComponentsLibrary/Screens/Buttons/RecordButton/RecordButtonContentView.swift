//  Created by Sergey Chsherbak (Personal) on 30/04/2023.

import Components
import UIKit

final class RecordButtonContentView: UIView {
    
    // MARK: - UI Elements
    
    private let backgroundImage: UIImageView = {
        let this = UIImageView(image: UIImage(named: "record_button_screen_background"))
        this.translatesAutoresizingMaskIntoConstraints = false
        this.contentMode = .scaleToFill
        return this
    }()
    
    let button: RecordButton = {
        let this = RecordButton()
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
        addSubview(backgroundImage)
        addSubview(button)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
}
