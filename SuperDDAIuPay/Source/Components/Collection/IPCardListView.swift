//
//  IPCardListView.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 21/08/2020.
//

import UIKit

// MARK: - Class

/**
 View to be used to display a collection of cards
 */
public class IPCardListView: UIView {
    
    // MARK: Public variables
    public var handleCardSelected: ((IPCardItem) -> ())?
    
    // MARK: Private variables
    private lazy var tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.register(IPCardCollectionCell.self, forCellReuseIdentifier: IPCardCollectionCell.identifier)
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.clipsToBounds = false
        $0.bounces = false
        return $0
    }(UITableView(frame: .zero))
    
    private lazy var footerLabel: UILabel = {
       $0.font = .customFont(ofSize: 14, weight: .regular)
       $0.textColor = .grayKit
       $0.textAlignment = .left
       return $0
   }(UILabel(frame: .zero))
    
    private var featuredTextColor: UIColor = .darkGray
    private var headerTitle: String?
    
    private var source: [IPCardItem] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: Initializers
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialSetup()
    }
    
    // MARK: Lifecycle methods
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.tableView.backgroundColor = .clear
    }
    
    // MARK: Public methods
        
    /**
     Set settings for the component  the given parameters.
     
     - parameter source: List of cards to fill the component.
     - parameter featured: Flag to set as spotlight
     - parameter featuredColor: Spotlight color.
     - parameter featuredTextColor: Color of bottom text (Default: .darkText)..
     - parameter featuredPaymentText: Text to describe the total amount displayed at the bottom of the view..
     - parameter totalAlignment: Alignment for the featuredPaymentText..
     - parameter totalDueOnly: set if should be displayed only the total for dueDates..
     */
    
    public func configure(source: [IPCardItem],
                          featured: Bool = false,
                          featuredColor: UIColor = .clear,
                          featuredTextColor: UIColor = .darkText,
                          titleText: String? = nil,
                          totalPaymentText: NSAttributedString = NSAttributedString(string:""),
                          totalAlignment: NSTextAlignment = .center,
                          totalDueOnly: Bool = false) {
        
        self.source = source
        
        self.headerTitle = titleText
        self.featuredTextColor = featuredTextColor
        
        if featured {
            self.backgroundColor = featuredColor
            self.footerLabel.textColor = featuredTextColor
        }
        
        let captionAttribute = [
            NSAttributedString.Key.font: UIFont.customFont(ofSize: 13, weight: .regular),
            NSAttributedString.Key.foregroundColor: featuredTextColor
        ]
        
        let symbol = NSAttributedString(string: "R$ ", attributes: captionAttribute as [NSAttributedString.Key : Any])
        
        let focusedAttribute = [
            NSAttributedString.Key.font: UIFont.customFont(ofSize: 17, weight: .bold),
            NSAttributedString.Key.foregroundColor: featuredTextColor
        ]
    
        
        let totalAmount = NSAttributedString(string: String(format: "%2.f", self.calculateTotal(dueOnly: totalDueOnly)), attributes: focusedAttribute as [NSAttributedString.Key : Any])
        
        let combination = NSMutableAttributedString()
        combination.append(totalPaymentText)
        combination.append(symbol)
        combination.append(totalAmount)
                
        self.footerLabel.frame = .init(x: 0, y: 0, width: self.frame.width, height: 56)
        self.footerLabel.attributedText = combination
        self.footerLabel.textAlignment = totalAlignment
        self.footerLabel.numberOfLines = 0
        
        self.tableView.tableFooterView = self.footerLabel
    }
    
    // MARK: Private methods
    private func initialSetup() {
        self.addSubview(self.tableView)
        self.clipsToBounds = true
        self.tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: .bigMediumMargin).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .mediumMargin).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.mediumMargin).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -.smallestMargin).isActive = true
    }
    
    private func calculateTotal(dueOnly: Bool) -> Double {
        let today = "\(Date().getDay) \(Date().getMonthName())".uppercased()
        
        return self.source
                    .filter({ item in
                        guard dueOnly else { return true }
                        if item.formattedDate() == today { return true }
                        return false
                    })
                    .map({ $0.amount })
                    .reduce(0, +)
    }
}

// MARK: - UITableViewDelegate and DataSource
extension IPCardListView: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.source.count + 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: IPCardCollectionCell.identifier) as? IPCardCollectionCell
        else { fatalError("reusable cell not found") }
        
        if indexPath.row == 0 {
            let cellHeader = UITableViewCell(frame: .zero)
            cellHeader.backgroundColor = .clear
            cellHeader.textLabel?.text = self.headerTitle
            cellHeader.textLabel?.textColor = featuredTextColor
            cellHeader.textLabel?.font = UIFont.customFont(ofSize: 14, weight: .bold)
            return cellHeader
        }
        cell.configure(card: self.source[indexPath.row-1], isLast: self.source.count == indexPath.row)
        cell.layer.zPosition = CGFloat(indexPath.row)

        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return .defaultArea
        }
        return 70
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.handleCardSelected?(self.source[indexPath.row])
    }
}
