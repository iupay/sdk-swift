//
//  CardCollectionCell.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 21/08/2020.
//

import UIKit
import Valley

public class CardCollectionCell: UITableViewCell {

    private lazy var leftBarView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView(frame: .zero))
    
    private lazy var logoImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView(frame: .zero))
    
    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .customFont(ofSize: 14, weight: .semibold)
        $0.textColor = .lightGrayKit
        $0.textAlignment = .left
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var dateLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .customFont(ofSize: 11, weight: .semibold)
        $0.textColor = .lightGrayKit
        $0.textAlignment = .right
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var amountLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .customFont(ofSize: 14, weight: .bold)
        $0.textColor = .lightGrayKit
        $0.textAlignment = .left
        return $0
    }(UILabel(frame: .zero))
    
    private var isLast: Bool = false
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupLayout()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        var radius: CACornerMask = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        if isLast {
            radius = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            radius = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
        self.contentView.layer.cornerRadius = .smallestMargin
        self.contentView.layer.maskedCorners = radius
        self.contentView.layer.masksToBounds = false
        self.contentView.layer.shadowRadius = 7
        self.contentView.layer.shadowOpacity = 0.3
        self.contentView.layer.shadowColor = UIColor.darkGray.cgColor
       
        self.leftBarView.roundCorners(corners: isLast ? [.bottomLeft, .topLeft] : [.topLeft], radius: .smallestMargin)
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: -.smallMargin/2, left: 0, bottom: 0, right: 0))
    }
    
    func configure(card: CardItem, isLast: Bool) {
        self.titleLabel.text = card.cardTitle
        self.leftBarView.backgroundColor = card.barColor
        self.dateLabel.text = card.formattedDate()
        self.amountLabel.text = String(format: "R$ %.2f", card.amount)
        self.isLast = isLast
        switch card.type {
        case .standard(let url):
            self.logoImageView.valleyImage(url: url, transition: .curveEaseIn,
                                       onSuccess: { [weak self] (image) in
                self?.logoImageView.image = image.resize(toHeight: .preLargeMargin)
                self?.logoImageView.widthAnchor.constraint(equalToConstant: self?.logoImageView.image?.size.width ?? .largeMargin).isActive = true
                self?.logoImageView.layoutIfNeeded()
            })
        default:
            self.logoImageView.image = card.type.image?.resize(toHeight: .largeMargin)
            self.logoImageView.widthAnchor.constraint(equalToConstant: self.logoImageView.image?.size.width ?? .largeMargin).isActive = true
        }
    }
    
    private func setupLayout() {
        self.contentView.addSubview(self.leftBarView)
        self.contentView.addSubview(self.logoImageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.dateLabel)
        self.contentView.addSubview(self.amountLabel)

        self.backgroundColor = .clear
        self.contentView.backgroundColor = .white
        leftBarView: do {
            self.leftBarView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
            self.leftBarView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
            self.leftBarView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: !isLast ?  .zero : .smallestMargin).isActive = true
            self.leftBarView.widthAnchor.constraint(equalToConstant: .smallestMargin).isActive = true
        }
        
        imageView: do {
            self.logoImageView.leadingAnchor.constraint(equalTo: self.leftBarView.trailingAnchor,
                                                    constant: .smallMargin).isActive = true
            self.logoImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
            self.logoImageView.heightAnchor.constraint(equalToConstant: .defaultArea).isActive = true
            self.logoImageView.widthAnchor.constraint(equalToConstant: .defaultArea).isActive = true
        }
        
        titleLabel: do {
            self.titleLabel.centerYAnchor.constraint(equalTo: self.logoImageView.centerYAnchor).isActive = true
            self.titleLabel.leadingAnchor.constraint(equalTo: self.logoImageView.trailingAnchor,
                                                     constant: .smallMargin).isActive = true
            self.titleLabel.trailingAnchor.constraint(equalTo: self.dateLabel.leadingAnchor,
                                                      constant:  -.smallestMargin).isActive = true
        }
        
        amountLabel: do {
            self.amountLabel.centerYAnchor.constraint(equalTo: self.logoImageView.centerYAnchor, constant: .smallestMargin).isActive = true
            self.amountLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                                     constant: -.smallMargin).isActive = true
            self.amountLabel.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor,
                                                      constant: .smallestMargin).isActive = true
        }
        
        dateLabel: do {
            self.dateLabel.bottomAnchor.constraint(equalTo: self.amountLabel.topAnchor).isActive = true
            self.dateLabel.trailingAnchor.constraint(equalTo: self.amountLabel.trailingAnchor).isActive = true
        }
    }
}

public extension CardCollectionCell {
    static let identifier = String(describing: CardCollectionCell.self)
}