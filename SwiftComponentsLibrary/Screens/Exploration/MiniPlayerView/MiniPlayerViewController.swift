//  Created by Sergey Chsherbak on 06/05/2023.

import Components
import UIKit

final class MiniPlayerViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView = MiniPlayerContentView()
    private let songs = [
        MiniPlayerView.Song(previewColor: .systemYellow, title: "MANIAC (feat. Windser)", subtitle: "Macklemore"),
        MiniPlayerView.Song(previewColor: .systemPink, title: "Chanel", subtitle: "Frank Ocean"),
        MiniPlayerView.Song(previewColor: .systemRed, title: "Reflex", subtitle: "SAINt JHN")
    ]
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "MiniPlayerView"
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
        setupPlayerView()
        setupTargets()
    }
    
    // MARK: - Setup
    
    private func setupPlayerView() {
        contentView.playerView.configure(with: songs[0])
    }
    
    private func setupTargets() {
        contentView.playerView.playButton.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
        contentView.playerView.pauseButton.addTarget(self, action: #selector(didTapPauseButton), for: .touchUpInside)
        contentView.playerView.forwardButton.addTarget(self, action: #selector(didTapForwardButton), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func didTapPlayButton() {
        contentView.playerView.play()
        contentView.stateLabel.text = "Music is being played"
    }
    
    @objc private func didTapPauseButton() {
        contentView.playerView.pause()
        contentView.stateLabel.text = "Music is paused"
    }
    
    @objc private func didTapForwardButton() {
        let song = songs.randomElement()!
        contentView.playerView.configure(with: song)
    }
}
