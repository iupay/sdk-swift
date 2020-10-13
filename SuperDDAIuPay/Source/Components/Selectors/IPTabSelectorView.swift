//
//  IPTabSelectorView.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 25/08/2020.
//

import UIKit

// MARK: - Class
public class IPTabSelectorView: UIView {
    
    // MARK: Public variables
    public var handleItemChange: ((Int) -> ())?
    
    // MARK: Private variables
    private var currentItem: Int = 0 {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private lazy var tabColor: UIColor = .systemRed
    
    private lazy var collectionView: UICollectionView = {
        
        $0.register(TabCollectionCell.self,
                    forCellWithReuseIdentifier: TabCollectionCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        if let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.itemSize = CGSize(width: 100, height: 46)
            layout.invalidateLayout()
        }
        $0.bounces = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .white
        $0.collectionViewLayout = layout
        $0.delegate = self
        $0.dataSource = self
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    private var items: [String] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: Initializers
    public init(items: [String], tabColor: UIColor) {
        super.init(frame: .zero)
        self.configure(items: items, tabColor: tabColor)
        self.setupConstraints()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupConstraints()
    }
    
    // MARK: Public methods
    
    /// Set settings for the component
    /// from the given parameters.
    ///
    /// - Parameters:
    ///     - tabColor: Main color that will be use as theme for the component

    public func configure(items: [String], tabColor: UIColor) {
        self.tabColor = tabColor
        self.items = items
    }
    
    /// Set settings for the component
    /// from the given parameters.
    ///
    /// - Parameters:
    ///     - currentMonth: Month that will be presented in the center of the component
    public func set(currentIndex index: Int) {
        self.currentItem = index
    }
    
    // MARK: Private methods
    private func setupConstraints() {
        self.addSubview(self.collectionView)
        self.collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.collectionView.heightAnchor.constraint(equalToConstant: 46).isActive = true
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension IPTabSelectorView: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabCollectionCell.identifier, for: indexPath) as? TabCollectionCell else {
            return UICollectionViewCell()
        }
        
        cell.setup(withItem: self.items[indexPath.row],
                   selected: self.currentItem == indexPath.row,
                   color: self.tabColor)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        self.currentItem = index
        
        DispatchQueue.main.async {
            self.handleItemChange?(index)
        }
    }
}

// MARK: - Month Cell
private final class TabCollectionCell: UICollectionViewCell {
    
    // MARK: Static variable for cell identifier
    static let identifier = String(describing: TabCollectionCell.self)
    
    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.font = UIFont.customFont(ofSize: 14, weight: .semibold)
        return $0
    }(UILabel(frame: .zero))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupConstraints() {
        self.addSubview(self.titleLabel)
        
        self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.layer.cornerRadius = .smallestMargin
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
   
    func setup(withItem item: String, selected: Bool, color: UIColor) {
        self.titleLabel.text = item
        self.titleLabel.textColor = selected ? color : .lightGrayKit
        self.titleLabel.backgroundColor = color.withAlphaComponent(selected ? 0.2 : 0.0)
    }
}
