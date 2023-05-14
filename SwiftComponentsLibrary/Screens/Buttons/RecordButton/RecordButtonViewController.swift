//  Created by Sergey Chsherbak (Personal) on 30/04/2023.

import UIKit

final class RecordButtonViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = RecordButtonContentView()
    private var isRecording: Bool = false
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "RecordButton"
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
        setupTargets()
    }
    
    // MARK: - Setup
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupTargets() {
        contentView.button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func didTapButton() {
        if isRecording {
            contentView.button.stopRecording()
        } else {
            contentView.button.startRecording()
        }
        isRecording.toggle()
    }
}
