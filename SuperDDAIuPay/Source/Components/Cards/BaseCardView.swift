//
//  FeaturedCardView.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 15/08/2020.
//

import UIKit

// MARK: - Class
public class BaseCardView: UIView {
    
    // MARK: Private variables
    
    private lazy var leftBarView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView(frame: .zero))
    
    private lazy var imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView(frame: .zero))
    
    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .customFont(ofSize: 14, weight: .semibold)
        $0.textAlignment = .left
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var dateLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .customFont(ofSize: 13, weight: .bold)
        $0.textAlignment = .right
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var cnpjLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .customFont(ofSize: 13, weight: .semibold)
        $0.textAlignment = .left
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var textLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .customFont(ofSize: 13, weight: .regular)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var paidLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .customFont(ofSize: 12, weight: .bold)
        $0.textColor = .init(red: 138/255, green: 166/255, blue: 38/255, alpha: 1.0)
        $0.isHidden = true
        $0.text = "PAGO"
        $0.textAlignment = .right
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var amountLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .customFont(ofSize: 13, weight: .regular)
        $0.textAlignment = .right
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var badgesStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        return $0
    }(UIStackView(frame: .zero))
    
    private lazy var contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.layer.cornerRadius = .smallestMargin
        return $0
    }(UIView(frame: .zero))
    
    private lazy var featuredView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView(frame: .zero))
    
    private var leadingFeature: NSLayoutConstraint?
    private var trailingFeature: NSLayoutConstraint?

    // MARK: Overridden inits
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupConstraints()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupConstraints()
    }
        
    // MARK: Public methods
    
    /// Creates the Beneficiary Card View
    /// from the given parameters.
    ///
    /// - Parameters:
    ///     - barColor: Left bar color
    ///     - cardTextColor: Text color
    ///     - cardTitle: Card's title text
    ///     - cnpj: cnpj text
    ///     - paid: if bill was paid
    ///     - due: if is due date
    ///     - amount: Amount value
    ///     - date: date to be displayed
    ///     - text: text description
    ///     - imageUrl: Color of the left bar
    
    public func configure(settings: BaseConfig) {
        
        [self.titleLabel,
         self.amountLabel,
         self.dateLabel,
         self.textLabel,
         self.cnpjLabel].forEach({ label in
            label.textColor = settings.cardTextColor
        })
        
        self.textLabel.text = settings.text
        self.cnpjLabel.text = "CNPJ: \(settings.cnpj)"
        
        
        let captionAttribute = [
            NSAttributedString.Key.font: UIFont.customFont(ofSize: 13, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.from(hex: "#7a7a7b")
        ]
        
        let symbol = NSAttributedString(string: "R$ ", attributes: captionAttribute as [NSAttributedString.Key : Any])
        
        let focusedAttribute = [
            NSAttributedString.Key.font: UIFont.customFont(ofSize: 17, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.from(hex: "#7a7a7b")
        ]
        
        let totalAmount = NSAttributedString(string: String(format: "%2.f", settings.amount), attributes: focusedAttribute as [NSAttributedString.Key : Any])
        
        let combination = NSMutableAttributedString()
        combination.append(symbol)
        combination.append(totalAmount)
        
        self.amountLabel.attributedText = combination
        self.dateLabel.text = settings.date.uppercased()
        self.leftBarView.backgroundColor = settings.barColor
        self.paidLabel.isHidden = !settings.paid
        self.contentView.backgroundColor = .white
        
        if settings.featured {
            self.featuredView.backgroundColor = settings.featuredColor
            self.setupFeatured()
        }
        
        if settings.fromEmail {
            let mailImage = UIImageView(image: UIImage.bundleImage(named: "mail")?.tint(with: settings.cardTextColor))
            mailImage.widthAnchor.constraint(equalToConstant: .bigMediumMargin).isActive = true
            mailImage.contentMode = .scaleAspectFit
            self.badgesStackView.addArrangedSubview(mailImage)
        }
        
        let userImage = UIImageView(image: UIImage.bundleImage(named: settings.addedByUser ? "user-check" : "user-x")?.tint(with: settings.addedByUser ? .systemGreen : settings.cardTextColor))
        userImage.widthAnchor.constraint(equalToConstant: .bigMediumMargin).isActive = true
        userImage.contentMode = .scaleAspectFit
        self.badgesStackView.addArrangedSubview(userImage)
        
        if settings.isDue {
            self.dateLabel.text = "\(settings.dueText), \(settings.date)"
            self.dateLabel.textColor = .redKit
            self.dateLabel.font = .customFont(ofSize: 14, weight: .bold)
        }
        
        switch settings.type {
        case .standard(let image):
            guard let url = image else { return }
            self.imageView.valleyImage(url: url, transition: .curveEaseIn,
                                       onSuccess: { [weak self] (image) in
                self?.imageView.image = image.resize(toHeight: .preLargeMargin)
                self?.imageView.widthAnchor.constraint(equalToConstant: self?.imageView.image?.size.width ?? .largeMargin).isActive = true
                self?.imageView.layoutIfNeeded()
                self?.titleLabel.text = settings.cardTitle
            })
        case .lightbill(let flag):
            self.textLabel.font = .customFont(ofSize: 12, weight: .bold)
            self.textLabel.textColor = flag.color
            fallthrough
            
        default:
            self.imageView.image = settings.type.image?.resize(toHeight: .largeMargin)
            self.imageView.widthAnchor.constraint(equalToConstant: self.imageView.image?.size.width ?? .largeMargin).isActive = true
        }
    }
    
    public override func layoutSubviews() {
        contentView.layer.cornerRadius = .smallestMargin
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = false
        contentView.layer.shadowRadius = 7
        contentView.layer.shadowOpacity = 0.6
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        contentView.layer.shadowColor = UIColor.darkGray.cgColor
        
        self.leftBarView.roundCorners(corners: [.bottomLeft, .topLeft], radius: .smallestMargin)
    }
    
    // MARK: Private methods
    private func setupConstraints() {
        self.addSubview(self.contentView)
        self.addSubview(self.featuredView)
        
        self.contentView.addSubview(self.leftBarView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.paidLabel)
        self.contentView.addSubview(self.cnpjLabel)
        self.contentView.addSubview(self.textLabel)
        self.contentView.addSubview(self.amountLabel)
        self.contentView.addSubview(self.dateLabel)
        self.contentView.addSubview(self.badgesStackView)
        
        self.sendSubviewToBack(self.featuredView)
        
        featuredView: do {
            self.featuredView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            self.featuredView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            self.featuredView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            self.featuredView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        }
        
        contentView: do {
            self.leadingFeature = self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            self.trailingFeature = self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            self.contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            self.contentView.heightAnchor.constraint(equalToConstant: 125).isActive = true
            
            leadingFeature?.isActive = true
            trailingFeature?.isActive = true
        }
        
        leftBarView: do {
            self.leftBarView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
            self.leftBarView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
            self.leftBarView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
            self.leftBarView.widthAnchor.constraint(equalToConstant: .smallestMargin).isActive = true
        }
        
        imageView: do {
            self.imageView.leadingAnchor.constraint(equalTo: self.leftBarView.trailingAnchor,
                                                    constant: .smallMargin).isActive = true
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                                constant: .smallestMargin).isActive = true
            self.imageView.heightAnchor.constraint(equalToConstant: .defaultArea).isActive = true
        }
        
        titleLabel: do {
            self.titleLabel.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor).isActive = true
            self.titleLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor,
                                                     constant: .smallMargin).isActive = true
            self.titleLabel.trailingAnchor.constraint(equalTo: self.dateLabel.leadingAnchor,
                                                      constant:  -.smallestMargin).isActive = true
        }
        
        typeLabel: do {
            self.dateLabel.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor).isActive = true
            self.dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                                     constant: -.mediumMargin).isActive = true
        }
        
        cnpjLabel: do {
            self.cnpjLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor,
                                                constant: .smallestMargin).isActive = true
            self.cnpjLabel.leadingAnchor.constraint(equalTo: self.leftBarView.trailingAnchor,
                                                    constant: .smallMargin).isActive = true
            self.cnpjLabel.trailingAnchor.constraint(equalTo: self.paidLabel.trailingAnchor,
                                                     constant: .smallestMargin).isActive = true
            self.cnpjLabel.heightAnchor.constraint(equalToConstant: .mediumMargin).isActive = true
        }
        
        paidLabel: do {
            self.paidLabel.topAnchor.constraint(equalTo: self.cnpjLabel.topAnchor).isActive = true
            self.paidLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                                     constant: -.mediumMargin).isActive = true
            self.paidLabel.widthAnchor.constraint(equalToConstant: .defaultArea).isActive = true
            self.paidLabel.heightAnchor.constraint(equalToConstant: .mediumMargin).isActive = true
        }
        
        textLabel: do {
            self.textLabel.topAnchor.constraint(equalTo: self.cnpjLabel.bottomAnchor).isActive = true
            self.textLabel.leadingAnchor.constraint(equalTo: self.cnpjLabel.leadingAnchor).isActive = true
            self.textLabel.heightAnchor.constraint(equalToConstant: .mediumMargin).isActive = true
        }
        
        amountLabel: do {
            self.amountLabel.topAnchor.constraint(equalTo: self.textLabel.bottomAnchor).isActive = true
            self.amountLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                                    constant: -.mediumMargin).isActive = true
        }
        
        badgesStackView: do {
            self.badgesStackView.topAnchor.constraint(equalTo: textLabel.bottomAnchor,
                                                      constant: .smallestMargin).isActive = true
            self.badgesStackView.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor).isActive = true
            self.badgesStackView.trailingAnchor.constraint(equalTo: self.amountLabel.leadingAnchor,
                constant: -.smallestMargin).isActive = true
            self.badgesStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                constant: -.smallestMargin).isActive = true
        }
    }
    
    private func setupFeatured() {
        self.leadingFeature?.constant = 16
        self.trailingFeature?.constant = -16
        self.layoutIfNeeded()
    }
}

// MARK: - Definitions
public struct BaseConfig {
    var barColor: UIColor
    var dueText: String
    var cardTextColor: UIColor
    var cardTitle: String? = nil
    var cnpj: String
    var paid: Bool
    var isDue: Bool
    var fromEmail: Bool
    var addedByUser: Bool
    var amount: Double
    var date: String
    var text: String
    var imageUrl: String? = nil
    var featured: Bool = false
    var featuredColor: UIColor? = nil
    var type: BaseCardType = .standard(image: nil)
    
    public init(barColor: UIColor,
         dueText: String,
         cardTextColor: UIColor,
         cardTitle: String? = nil,
         cnpj: String,
         paid: Bool,
         isDue: Bool,
         fromEmail: Bool,
         addedByUser: Bool,
         amount: Double,
         date: String,
         text: String,
         imageUrl: String? = nil,
         featured: Bool = false,
         featuredColor: UIColor? = nil,
         type: BaseCardType = .standard(image: nil)) {
        self.barColor = barColor
        self.dueText = dueText
        self.cardTextColor = cardTextColor
        self.cardTitle = cardTitle
        self.cnpj = cnpj
        self.paid = paid
        self.isDue = isDue
        self.fromEmail = fromEmail
        self.addedByUser = addedByUser
        self.amount = amount
        self.date = date
        self.text = text
        self.imageUrl = imageUrl
        self.featured = featured
        self.featuredColor = featuredColor
        self.type = type
    }
}
