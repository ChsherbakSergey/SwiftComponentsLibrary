//  Created by Sergey Chsherbak on 13/05/2023.

import Components
import UIKit

final class SlideButtonViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = SlideButtonContentView()
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "SlideButton"
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
        setupNavigationBar()
        setupDelegates()
        setupTargets()
    }
    
    // MARK: - Setup
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupDelegates() {
        contentView.button.delegate = self
    }
    
    private func setupTargets() {
        contentView.titleTextSegmentedControl.addTarget(self, action: #selector(titleTextDidChange(_:)), for: .valueChanged)
        contentView.baseBackgroundColorSegmentedControl.addTarget(self, action: #selector(baseBackgroundColorDidChange(_:)), for: .valueChanged)
        contentView.handleBaseBackgroundColorSegmentedControl.addTarget(self, action: #selector(handleBaseBackgroundColorDidChange(_:)), for: .valueChanged)
        contentView.handleBaseForegroundColorSegmentedControl.addTarget(self, action: #selector(handleBaseForegroundColorDidChange(_:)), for: .valueChanged)
    }
    
    // MARK: - Actions
    
    @objc private func titleTextDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            contentView.button.title = "Approve"
        } else if sender.selectedSegmentIndex == 1 {
            contentView.button.title = "Star the project"
        } else {
            contentView.button.title = "Slide to open"
        }
    }
    
    @objc private func baseBackgroundColorDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            contentView.button.baseBackgroundColor = .systemBlue
        } else if sender.selectedSegmentIndex == 1 {
            contentView.button.baseBackgroundColor = .systemGreen
        } else {
            contentView.button.baseBackgroundColor = .systemIndigo
        }
    }
    
    @objc private func handleBaseBackgroundColorDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            contentView.button.handleBaseBackgroundColor = .white
        } else if sender.selectedSegmentIndex == 1 {
            contentView.button.handleBaseBackgroundColor = .systemGray6
        }
    }
    
    @objc private func handleBaseForegroundColorDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            contentView.button.handleBaseForegroundColor = .systemBlue
        } else if sender.selectedSegmentIndex == 1 {
            contentView.button.handleBaseForegroundColor = .systemGreen
        } else {
            contentView.button.handleBaseForegroundColor = .systemIndigo
        }
    }
}

// MARK: - SlideButtonDelegate

extension SlideButtonViewController: SlideButtonDelegate {
    func didFinishSliding() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.contentView.button.finish()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}
