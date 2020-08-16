//
//  BeneficiaryCardView.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 12/08/2020.
//

import UIKit
import Valley
import Material

// MARK: - Class
public class BeneficiaryCardView: UIView {

    // MARK: Public variables
    public var handleSelectorChange: ((Bool) -> ())?
    
    // MARK: Private variables
    
    private lazy var leftBarView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView(frame: .zero))
    
    private lazy var imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView(frame: .zero))
    
    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .customFont(ofSize: 14, weight: .semibold)
        $0.textAlignment = .left
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var typeLabel: UILabel = {
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
        $0.font = .customFont(ofSize: 13, weight: .semibold)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var limitLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .customFont(ofSize: 11, weight: .semibold)
        $0.textAlignment = .left
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var toggleView: Switch = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.buttonOnColor = .red
        $0.buttonDiameter = .mediumMargin
        $0.buttonOffColor = .darkGray
        $0.trackOffColor = UIColor.darkGray.withAlphaComponent(0.7)
        $0.trackThickness = 7.0
        $0.addTarget(self, action: #selector(self.selectorDidChange), for: .valueChanged)
        return $0
    }(Switch(state: .off, size: .medium))
    
    private lazy var contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.layer.cornerRadius = .smallestMargin
        return $0
    }(UIView(frame: .zero))
    
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
    ///     - frame: Default value is .zero
    ///     - barColor: Left bar color
    ///     - cardTextColor: Text color
    ///     - selectorColor: Selector color
    ///     - cardTitle: Card's title text
    ///     - cnpj: cnpj text
    ///     - activated: Set if selector is activated
    ///     - amountLimit: Amount limit value
    ///     - amountLimitText: Amount limit text
    ///     - imageUrl: Color of the left bar
    
    public func configure(settings: BeneficiaryConfig) {
        
        self.leftBarView.backgroundColor = settings.barColor
        self.titleLabel.text = settings.cardTitle
        self.typeLabel.text = settings.type.rawValue
        self.cnpjLabel.text = "CNPJ: \(settings.cnpj)"
        self.limitLabel.text = settings.limitFormatted
        self.textLabel.text = settings.text
        
        [self.titleLabel,
         self.typeLabel,
         self.textLabel,
         self.cnpjLabel,
         self.limitLabel].forEach({ label in
            label.textColor = settings.cardTextColor
        })
        
        self.toggleView.isOn = settings.activated
        self.toggleView.buttonOnColor = settings.selectorColor
        self.toggleView.trackOnColor = settings.selectorColor.withAlphaComponent(0.7)
        self.contentView.backgroundColor = .white
        self.imageView.valleyImage(url: settings.imageUrl, transition: .curveEaseIn,
                                   onSuccess: { [weak self] (image) in
            self?.imageView.image = image.resize(toHeight: .largeMargin)
            self?.imageView.widthAnchor.constraint(equalToConstant: self?.imageView.image?.size.width ?? .largeMargin).isActive = true
            self?.imageView.layoutIfNeeded()
        })
    }
    
    public override func layoutSubviews() {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 8.0)
        self.layer.cornerRadius = .smallestMargin
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    // MARK: Private methods
    private func setupConstraints() {
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.leftBarView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.typeLabel)
        self.contentView.addSubview(self.cnpjLabel)
        self.contentView.addSubview(self.textLabel)
        self.contentView.addSubview(self.limitLabel)
        self.contentView.addSubview(self.toggleView)
        
        contentView: do {
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            self.contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            self.contentView.heightAnchor.constraint(equalToConstant: 125).isActive = true
        }
        
        leftBarView: do {
            self.leftBarView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
            self.leftBarView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
            self.leftBarView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
            self.leftBarView.widthAnchor.constraint(equalToConstant: .smallestMargin).isActive = true
        }
        
        imageView: do {
            self.imageView.leadingAnchor.constraint(equalTo: self.leftBarView.trailingAnchor,
                                                    constant: .mediumMargin).isActive = true
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                                constant: .smallestMargin).isActive = true
            self.imageView.heightAnchor.constraint(equalToConstant: .defaultArea).isActive = true
        }
        
        titleLabel: do {
            self.titleLabel.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor).isActive = true
            self.titleLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor,
                                                     constant: .smallMargin).isActive = true
            self.titleLabel.trailingAnchor.constraint(equalTo: self.typeLabel.leadingAnchor,
                                                      constant:  -.smallestMargin).isActive = true
        }
        
        typeLabel: do {
            self.typeLabel.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor).isActive = true
            self.typeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                                     constant: -.mediumMargin).isActive = true
            self.typeLabel.widthAnchor.constraint(equalToConstant: .defaultArea * 2).isActive = true
        }
        
        cnpjLabel: do {
            self.cnpjLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor,
                                                constant: .smallestMargin).isActive = true
            self.cnpjLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                                    constant: .mediumMargin).isActive = true
            self.cnpjLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                                     constant: -.smallestMargin).isActive = true
            self.cnpjLabel.heightAnchor.constraint(equalToConstant: .mediumMargin).isActive = true
        }
        
        textLabel: do {
            self.textLabel.topAnchor.constraint(equalTo: self.cnpjLabel.bottomAnchor,
                                                constant: .smallMargin).isActive = true
            self.textLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                                    constant: .mediumMargin).isActive = true
            self.textLabel.heightAnchor.constraint(equalToConstant: .mediumMargin).isActive = true
        }
        
        limitLabel: do {
            self.limitLabel.topAnchor.constraint(equalTo: self.textLabel.bottomAnchor).isActive = true
            self.limitLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                                    constant: .mediumMargin).isActive = true
            self.limitLabel.heightAnchor.constraint(equalToConstant: .mediumMargin).isActive = true
        }
        
        toggleView: do {
            self.toggleView.centerYAnchor.constraint(equalTo: self.textLabel.centerYAnchor).isActive = true
            self.toggleView.trailingAnchor.constraint(equalTo: self.typeLabel.trailingAnchor).isActive = true
            self.toggleView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        }
    }
    
    @objc private func selectorDidChange() {
        self.handleSelectorChange?(self.toggleView.isOn)
    }
}

// MARK: Definitions

public struct BeneficiaryConfig {
    public init(barColor: UIColor,
                cardTextColor: UIColor,
                selectorColor: UIColor,
                cardTitle: String,
                cnpj: String,
                activated: Bool,
                amount: Double,
                amountLabel: String,
                text: String,
                imageUrl: String,
                type: BeneficiaryType) {
        
        self.barColor = barColor
        self.cardTextColor = cardTextColor
        self.selectorColor = selectorColor
        self.cardTitle = cardTitle
        self.cnpj = cnpj
        self.activated = activated
        self.amount = amount
        self.amountLabel = amountLabel
        self.text = text
        self.imageUrl = imageUrl
        self.type = type
    }
            
    public enum BeneficiaryType: String {
        case account = "Conta"
        case monthly = "Mensalidade"
    }
    
    var barColor: UIColor
    var cardTextColor: UIColor
    var selectorColor: UIColor
    var cardTitle: String
    var cnpj: String
    var activated: Bool
    var amount: Double
    var amountLabel: String
    var text: String
    var imageUrl: String
    var type: BeneficiaryType
    
    var limitFormatted: String {
        return "\(self.amountLabel) \(String(format: "%.2f", self.amount))"
    }
}
