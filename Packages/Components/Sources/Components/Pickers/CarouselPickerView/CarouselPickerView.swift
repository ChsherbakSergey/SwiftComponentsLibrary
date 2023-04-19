//  Created by Sergey Chsherbak on 18/04/2023.

import UIKit

public final class CarouselPickerView: UIView {

    // MARK: - UI Elements
    
    private let valueView: UIView = {
        let this = UIView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.backgroundColor = .systemBlue
        this.layer.cornerCurve = .continuous
        this.layer.cornerRadius = 20
        return this
    }()

    private let valueLabel: UILabel = {
        let this = UILabel()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.font = .systemFont(ofSize: 15, weight: .bold)
        this.textColor = .white
        this.textAlignment = .center
        this.text = "0 %"
        return this
    }()

    private let collectionView: UICollectionView = {
        let layout = CarouselCollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 4, height: 80)
        let this = UICollectionView(frame: .zero, collectionViewLayout: layout)
        this.translatesAutoresizingMaskIntoConstraints = false
        this.backgroundColor = .clear
        this.bounces = false
        this.register(CarouselPickerViewCell.self, forCellWithReuseIdentifier: "CarouselPickerViewCell")
        return this
    }()

    // MARK: - Public properties
    
    public var baseSelectedForegroundColor: UIColor = .systemBlue {
        didSet {
            guard let layout = collectionView.collectionViewLayout as? CarouselCollectionViewFlowLayout else { return }
            layout.baseSelectedForegroundColor = baseSelectedForegroundColor
            layout.invalidateLayout()
        }
    }
    
    public var baseUnselectedForegroundColor: UIColor = .systemGray {
        didSet {
            guard let layout = collectionView.collectionViewLayout as? CarouselCollectionViewFlowLayout else { return }
            layout.baseUnselectedForegroundColor = baseUnselectedForegroundColor
            layout.invalidateLayout()
        }
    }
    
    public var spacing: CGFloat = 40 {
        didSet {
            guard let layout = collectionView.collectionViewLayout as? CarouselCollectionViewFlowLayout else { return }
            layout.spacing = spacing
            layout.invalidateLayout()
            updateValue()
            generateImpactFeedback()
        }
    }
    
    public var standardItemAlpha: CGFloat = 0.5 {
        didSet {
            guard let layout = collectionView.collectionViewLayout as? CarouselCollectionViewFlowLayout else { return }
            layout.standardItemAlpha = standardItemAlpha
            layout.invalidateLayout()
        }
    }
    
    public var standardItemScale: CGFloat = 0.65 {
        didSet {
            guard let layout = collectionView.collectionViewLayout as? CarouselCollectionViewFlowLayout else { return }
            layout.standardItemScale = standardItemScale
            layout.invalidateLayout()
        }
    }
    
    public private(set) var value: Int = 0

    // MARK: - Private properties
    
    private let numberOfBars: Int
    private let generator = UIImpactFeedbackGenerator(style: .soft)
    private var lastChosenIndexPath = IndexPath(item: 0, section: 0)

    private var visibleIndexPath: IndexPath? {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        return collectionView.indexPathForItem(at: visiblePoint)
    }

    // MARK: - Initialization
    
    public init(numberOfBars: Int) {
        self.numberOfBars = numberOfBars
        super.init(frame: .zero)
        setup()
        setupDelegates()
        setupSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Public methods
    
    public func scrollToValue(_ value: Int, animated: Bool) {
        guard let layout = collectionView.collectionViewLayout as? CarouselCollectionViewFlowLayout else { return }

        // Trying to call the method before the `viewDidAppear` method in the ViewController
        // Results in .zero frame of the CollectionView
        // Thus the `scrollToItem` method won't work. To solve the issue force layout before scrolling to a default item
        layoutIfNeeded()
        let normalizedValue = max(min(value, numberOfBars - 1), 0)
        let offset = (layout.minimumLineSpacing + layout.itemSize.width) * CGFloat(normalizedValue)
        collectionView.setContentOffset(CGPoint(x: offset, y: 0), animated: animated)
        self.value = normalizedValue
    }

    // MARK: - Setup
    
    private func setup() {
        backgroundColor = .systemBackground
    }

    private func setupDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func setupSubviews() {
        addSubview(valueView)
        valueView.addSubview(valueLabel)
        addSubview(collectionView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            valueView.topAnchor.constraint(equalTo: topAnchor),
            valueView.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueView.widthAnchor.constraint(equalToConstant: 72),
            valueView.heightAnchor.constraint(equalToConstant: 40),

            valueLabel.centerYAnchor.constraint(equalTo: valueView.centerYAnchor),
            valueLabel.centerXAnchor.constraint(equalTo: valueView.centerXAnchor),

            collectionView.topAnchor.constraint(equalTo: valueView.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension CarouselPickerView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfBars
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselPickerViewCell", for: indexPath) as! CarouselPickerViewCell
        cell.layer.cornerRadius = 2
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension CarouselPickerView: UICollectionViewDelegate {}

// MARK: - UIScrollViewDelegate

extension CarouselPickerView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateValue()
        generateImpactFeedback()
    }

    private func updateValue() {
        guard let itemIndex = visibleIndexPath?.item else { return }

        let valueForOneBar = Double(100) / Double(numberOfBars - 1) // Minus one because first bar shows 0
        let value = Double(itemIndex) * valueForOneBar
        let roundedValue = Int(value.rounded(.down))
        let valueText = "\(roundedValue) %"

        valueLabel.text = valueText
        self.value = roundedValue
    }

    private func generateImpactFeedback() {
        guard let indexPath = visibleIndexPath else { return }

        if lastChosenIndexPath != indexPath {
            generator.impactOccurred()
            lastChosenIndexPath = indexPath
        }
    }
}
