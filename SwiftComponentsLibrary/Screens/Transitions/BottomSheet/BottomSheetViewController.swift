//  Created by Sergey Chsherbak on 13/02/2024.

import UIKit

final class BottomSheetViewController: UIViewController {
    
    let button: UIButton = {
        let this = UIButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        this.setTitle("Dismiss", for: .normal)
        this.backgroundColor = .systemBlue
        this.layer.cornerCurve = .continuous
        this.layer.cornerRadius = 12
        return this
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 48)
        ])
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        dismiss(animated: true)
    }
}
