//
//  IPMonthSelectorView.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 14/08/2020.
//

import UIKit
import Material

// MARK: - Class
public class IPMonthSelectorView: UIView {
    
    // MARK: - Definitions
    struct MonthItem {
        var id: Int
        var text: String
        var selected: Bool
    }
    
    // MARK: Public variables
    public var handleMonthChange: ((Int) -> ())?
    
    // MARK: Private variables
    private var currentMonth: Int = Calendar.current.component(.month, from: Date()) {
        didSet {
            self.buildMenu()
        }
    }
    
    private lazy var tabColor: UIColor = .systemRed
    
    private lazy var collectionView: UICollectionView = {
        
        $0.register(MonthCollectionCell.self,
                    forCellWithReuseIdentifier: MonthCollectionCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        if let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.itemSize = CGSize(width: 80, height: 34)
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
    
    private var items: [MonthItem] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: Initializers
    init(tabColor: UIColor) {
        super.init(frame: .zero)
        self.configure(tabColor: tabColor)
        self.setupConstraints()
        self.buildMenu()
    }
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setupConstraints()
        self.buildMenu()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupConstraints()
        self.buildMenu()
    }
    
    // MARK: Public methods
    
    /// Set settings for the component
    /// from the given parameters.
    ///
    /// - Parameters:
    ///     - tabColor: Main color that will be use as theme for the component

    public func configure(tabColor: UIColor) {
        self.tabColor = tabColor
    }
    
    /// Set settings for the component
    /// from the given parameters.
    ///
    /// - Parameters:
    ///     - currentMonth: Month that will be presented in the center of the component
    public func set(currentMonth: Int) {
        self.currentMonth = currentMonth
    }
    
    // MARK: Private methods
    private func setupConstraints() {
        self.addSubview(self.collectionView)
        self.collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.collectionView.heightAnchor.constraint(equalToConstant: 34).isActive = true
    }
    
    private func buildMenu() {
        var months: [Date?] = [
            self.currentMonthDate().getPreviousMonth(byDecreasing: 2),
            self.currentMonthDate().getPreviousMonth(byDecreasing: 1),
            self.currentMonthDate()
        ]
        
        for i in 1...9 {
            months.append(self.currentMonthDate().getNextMonth(byAdding: i))
        }
        
        self.items = months
            .compactMap({ $0 })
            .map({ [weak self] item in
                MonthItem(id: item.getMonthNumber, text: item.getMonthName().uppercased(), selected: item.getMonthNumber == self?.currentMonth)
            })
    }
    
    private func updateSelected(forId id: Int) {
        for i in 0..<self.items.count {
            self.items[i].selected = items[i].id == id
        }
    }
    
    private func currentMonthDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = self.currentMonth
        dateComponents.day = 1
        guard let date = Calendar.current.date(from: dateComponents) else {
            fatalError("Date is mandatory")
        }
        return date
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension IPMonthSelectorView: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthCollectionCell.identifier, for: indexPath) as? MonthCollectionCell else {
            return UICollectionViewCell()
        }
        cell.setup(withMonth: self.items[indexPath.row], color: self.tabColor)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        self.updateSelected(forId: item.id)
        
        DispatchQueue.main.async {
            collectionView.reloadData()
            self.handleMonthChange?(item.id)
        }
    }
}

// MARK: - Month Cell
private final class MonthCollectionCell: UICollectionViewCell {
    
    // MARK: Static variable for cell identifier
    static let identifier = String(describing: MonthCollectionCell.self)
    
    private var monthItem: IPMonthSelectorView.MonthItem?
    
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
    }
   
    func setup(withMonth monthItem: IPMonthSelectorView.MonthItem, color: UIColor) {
        self.titleLabel.text = monthItem.text
        self.titleLabel.textColor = monthItem.selected ? .white : color
        self.titleLabel.backgroundColor = color.withAlphaComponent(monthItem.selected ? 1.0 : 0.2)
    }
}
