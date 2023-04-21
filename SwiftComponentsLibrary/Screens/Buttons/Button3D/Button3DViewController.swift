//  Created by Sergey Chsherbak on 20/04/2023.

import UIKit

final class Button3DViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = Button3DContentView()
    
    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Button3D"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargets()
    }
    
    // MARK: - Setup
    
    private func setupTargets() {
        contentView.styleSegmentedControl.addTarget(self, action: #selector(styleDidChange(_:)), for: .valueChanged)
        contentView.cornerRadiusSlider.addTarget(self, action: #selector(cornerRadiusSliderValueDidChange(_:)), for: .valueChanged)
        contentView.button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func styleDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            contentView.button.baseBackgroundColor = UIColor(red: 205/255, green: 59/255, blue: 48/255, alpha: 1)
            contentView.button.baseForegroundColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1)
            contentView.button.title = "⭐️  Star this project +10 XP"
        } else if sender.selectedSegmentIndex == 1 {
            contentView.button.baseBackgroundColor = UIColor(red: 230/255, green: 179/255, blue: 0/255, alpha: 1)
            contentView.button.baseForegroundColor = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1)
            contentView.button.title = "⭐️  Missing a star? +15 XP"
        } else {
            contentView.button.baseBackgroundColor = UIColor(red: 52/255, green: 149/255, blue: 89/255, alpha: 1)
            contentView.button.baseForegroundColor = UIColor(red: 52/255, green: 199/255, blue: 89/255, alpha: 1)
            contentView.button.title = "⭐️  Way to go! +35 XP"
        }
    }
    
    @objc private func cornerRadiusSliderValueDidChange(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        let roundedValue = round(value * 10) / 10.0

        contentView.cornerRadiusLabel.text = "Corner Radius: \(roundedValue)"
        contentView.button.cornerRadius = roundedValue
    }
    
    @objc private func didTapButton() {}
}
