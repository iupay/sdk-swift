//
//  IPBillDetailsModalViewController.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 08/09/2020.
//

import UIKit

// MARK: - Class

/**
 Modal to be used for Bill and Beneficary detail
 
 ### Usage: ###
```
// Check ModalType for options
IPBillDetailsModalViewController.showModal(from: benDetails,
                                            payment: # IPPayment object instance #,
                                            highlightColor: .systemRed,
                                            type: .beneficiary)
```
 */
public class IPBillDetailsModalViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: Private variables
    private lazy var contentView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = .smallestMargin
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        return $0
    }(UIView(frame: .zero))

    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .left
        $0.textColor = .grayKit
        $0.font = .customFont(ofSize: 16, weight: .bold)
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var headerView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .lightGrayKitBg
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var closeButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .grayKit
        $0.setImage(UIImage.bundleImage(named: "x-circle"), for: .normal)
        $0.addTarget(self, action: #selector(self.dismissModal), for: .touchUpInside)
        return $0
    }(UIButton(frame: .zero))
        
    private lazy var stackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView(frame: .zero))
    
    private let paymentDetails: IPPayment
    private let highlightColor: UIColor
    private let type: ModalType
    
    // MARK: - Initializers
    
    /**
     Custom initializer
     
     - parameter payment: Payment data.
     - parameter type: .bill or .beneficiary
     - parameter highlightColor: main color
    
     */
    public init(payment: IPPayment, type: ModalType, highlightColor: UIColor) {
        self.paymentDetails = payment
        self.highlightColor = highlightColor
        self.type = type
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle methods
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.64)
        self.view.isOpaque = false
        self.view.addSubview(self.contentView)
        self.contentView.addSubview(self.headerView)
        self.headerView.addSubview(self.titleLabel)
        self.headerView.addSubview(self.closeButton)
        self.contentView.addSubview(self.stackView)
        
        self.headerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.headerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.headerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.headerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.contentView.heightAnchor.constraint(equalToConstant: self.type == .bill ? 490 : 412).isActive = true
        self.contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .bigMediumMargin).isActive = true
        self.contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -.bigMediumMargin).isActive = true
        self.contentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        self.stackView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: .smallestMargin).isActive = true
        self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: .bigMediumMargin).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -.bigMediumMargin).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -.smallestMargin).isActive = true
        
        self.titleLabel.leadingAnchor.constraint(equalTo: self.headerView.leadingAnchor, constant: .bigMediumMargin).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.headerView.topAnchor).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.headerView.bottomAnchor).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.closeButton.leadingAnchor).isActive = true
        self.closeButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.closeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.closeButton.trailingAnchor.constraint(equalTo: self.headerView.trailingAnchor, constant: -.smallMargin).isActive = true
        self.closeButton.centerYAnchor.constraint(equalTo: self.headerView.centerYAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissModal))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        self.configure()
    }
    
    // MARK: Private methods
    private func configure() {
        
        guard let details = self.paymentDetails.billDetails else { return }
        var html = ""
        switch self.type {
        case .bill:
            self.titleLabel.text = "Detalhes da conta"
            html =
                "CNPJ \(self.paymentDetails.cnpj ?? "--")<br>" +
                "Cartão \(self.paymentDetails.cardNumber ?? "--")<br><br>" +
                "\(self.paymentDetails.cardHolderName ?? "--")<br>" +
                "<b>\(details.billDate?.formatDate(format: "MMM yyyy", fromFormat: "yyyy-mm") ?? "")</b><br>" +
                "Valor: <b>R$ \(String(describing: details.value).currencyInputFormatting(divide: false))</b><br>" +
                "Vencimento: <b>\(details.dueDate?.formatDate(format: "dd MMM yyyy") ?? "")</b><br>" +
                "Emissão e Envio: \(details.emissionDate?.formatDate(format: "dd MMM yyyy") ?? "")<br><br>" +
                "Pagamento mínimo: <b>R$ \(String(describing: details.minimumPaymentValue).currencyInputFormatting(divide: false))</b><br>" +
                "Limite total: R$ \(String(describing: details.totalLimitValue).currencyInputFormatting(divide: false))<br>" +
                "Limite de saque total: R$ \(String(describing: details.totalWithdrawLimitValue).currencyInputFormatting(divide: false))<br><br>" +
                "<b>Juros rotativo:</b><br>" +
                "\(details.interestRate ?? 0)% am CET: \(details.interestRateCET ?? 0)% aa<br><br>" +
                "<b>Juros de parcelamento:</b><br>" +
                "consulte o app na contratação<br>" +
                "Juros e mora em caso de atraso:<br>" +
                "\(details.interestInstallmentRate ?? 0)% am + \(details.interestInstallmentFine ?? 0)% multa CET: \(details.interestInstallmentRateCET ?? 0)% aa"
        case .beneficiary:
            self.titleLabel.text = "Detalhes do beneficiário"
            html =
                "CNPJ \(self.paymentDetails.cnpj ?? "--")<br>" +
                "Cartão \(self.paymentDetails.cardNumber ?? "--")<br><br>" +
                "<b>\(self.paymentDetails.cardHolderName ?? "--")</b><br><br>" +
                "<b>Endereço</b><br>" +
                "\(self.paymentDetails.cardHolderAddress ?? "")<br><br>" +
                "<b>Juros rotativo:</b><br>" +
                "\(details.interestRate ?? 0)% am CET: \(details.interestRateCET ?? 0)% aa<br><br>" +
                "<b>Juros de parcelamento:</b><br>" +
                "consulte o app na contratação<br>" +
                "Juros e mora em caso de atraso:<br>" +
                "\(details.interestInstallmentRate ?? 0)% am + \(details.interestInstallmentFine ?? 0)% multa CET: \(details.interestInstallmentRateCET ?? 0)% aa"
        }
        
        let contentLabel = UILabel(frame: .zero)
        contentLabel.numberOfLines = 0
        contentLabel.attributedText = html.convertHtml()
        contentLabel.sizeToFit()
        
        let companyName = UILabel(frame: .zero)
        companyName.text = self.paymentDetails.companyName ?? "-"
        companyName.font = UIFont.customFont(ofSize: 15, weight: .regular)
        companyName.textColor = self.highlightColor
        self.stackView.addArrangedSubview(companyName)
        self.stackView.addArrangedSubview(contentLabel)
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard
            (!self.contentView.bounds.contains(touch.location(in: self.contentView)) ||
                self.contentView.bounds.contains(touch.location(in: self.closeButton)))
        else {
           return false
        }
       return true
    }

    @objc private func dismissModal() {
        self.dismiss(animated: false)
    }
}

extension IPBillDetailsModalViewController {
    
    public enum ModalType {
        case bill
        case beneficiary
    }
    
    /**
     Static method to present the current controller modally and with transparent background
     
     - parameter vc: reference to the controller presenting it.
     - parameter payment: payment data to load into it
     - parameter highlightColor: main color
     - parameter type: .bill or .beneficiary
     */
    public static func showModal(from vc: UIViewController, payment: IPPayment, highlightColor: UIColor, type: ModalType)  {
        let modalViewController = IPBillDetailsModalViewController(payment: payment, type: type, highlightColor: highlightColor)
        vc.present(modalViewController, animated: false, completion: nil)
    }
}
