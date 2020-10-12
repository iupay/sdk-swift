//
//  IPPaymentDetailsViewController.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 07/10/2020.
//

import UIKit

public class IPPaymentDetailsViewController: UIViewController {

    @objc public var handleButtonClick: (() -> ())?
    
    private var beneficiaryName, navTitle, bankName, payerName, barcode, payWithType: String?
    private var scheduledDueDate: Date? = Date()
    private var dueDate: Date? = Date()
    private var paymentAmount, currentBalance: Double?
    private var baseColor: UIColor = .red
    private var isPayment: Bool = true
    
    private lazy var backButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage.bundleImage(named: "left-arrow"), for: .normal)
        $0.addTarget(self, action: #selector(self.closeAction), for: .touchUpInside)
        $0.tintColor = .darkGray
        return $0
    }(UIButton(frame: .zero))
    
    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.customFont(ofSize: 15, weight: .regular)
        $0.textColor = .darkGray
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        return $0
    }(UIStackView(frame: .zero))
    
    private lazy var mainButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = UIFont.customFont(ofSize: 16, weight: .bold)
        $0.addTarget(self, action: #selector(self.handleClick), for: .touchUpInside)
        return $0
    }(UIButton(frame: .zero))
    
    init(beneficiaryName: String,
         scheduledDueDate: Date,
         dueDate: Date,
         navTitle: String,
         paymentAmount: Double,
         currentBalance: Double,
         baseColor: UIColor,
         paymentMessage: String,
         payerName: String,
         bankName: String,
         barcode: String,
         payWithType: String,
         isPayment: Bool) {
        
        super.init(nibName: nil, bundle: nil)
        self.setContent(beneficiaryName: beneficiaryName,
                        scheduledDueDate: scheduledDueDate,
                        dueDate: dueDate,
                        navTitle: navTitle,
                        paymentAmount: paymentAmount,
                        currentBalance: currentBalance,
                        baseColor: baseColor,
                        paymentMessage: paymentMessage,
                        payerName: payerName,
                        bankName: bankName,
                        barcode: barcode,
                        payWithType: payWithType,
                        isPayment: isPayment)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupConstraints()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupConstraints() {
        self.view.addSubview(self.stackView)
        self.view.addSubview(self.mainButton)
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.titleLabel)
        
        self.backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: .smallMargin).isActive = true
        self.backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .mediumMargin).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: .bigMediumMargin).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: .bigMediumMargin).isActive = true
        
        self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.titleLabel.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: .largeMargin).isActive = true
       
        self.stackView.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: .bigMediumMargin).isActive = true
        self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.stackView.heightAnchor.constraint(equalToConstant: 440).isActive = true
    
        self.mainButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -.mediumMargin).isActive = true
        self.mainButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .bigMediumMargin).isActive = true
        self.mainButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -.bigMediumMargin).isActive = true
        self.mainButton.heightAnchor.constraint(equalToConstant: .defaultArea).isActive = true
    }
    
    private func setupLayout() {
        guard
            let scheduledDueDate = self.scheduledDueDate,
            let dueDate = self.dueDate,
            let name = self.beneficiaryName,
            let bank = self.bankName,
            let amount = self.paymentAmount,
            let payer = self.payerName,
            let barcode = self.barcode,
            let type = self.payWithType,
            let balance = self.currentBalance
        else { return }
        
        self.titleLabel.text = navTitle
        self.mainButton.backgroundColor = self.baseColor
        self.mainButton.setTitleColor(.white, for: .normal)
        self.mainButton.setTitle("Confirmar \(isPayment ? "Pagamento" : "Agendamento")", for: .normal)
        
        self.stackView.addArrangedSubview(self.label(caption: "Beneficiário",
                                                     text: name,
                                                     sizeCaption: 13,
                                                     sizeText: 15,
                                                     textColor: .grayKit))
        
        self.stackView.addArrangedSubview(self.label(caption: "Banco",
                                                     text: bank,
                                                     sizeCaption: 13,
                                                     sizeText: 15,
                                                     textColor: .grayKit))
        
        self.stackView.addArrangedSubview(self.label(caption: "Pagador",
                                                     text: payer,
                                                     sizeCaption: 13,
                                                     sizeText: 15,
                                                     textColor: .grayKit))
        
        self.stackView.addArrangedSubview(self.label(caption: "Código de Barras",
                                                     text: barcode,
                                                     sizeCaption: 13,
                                                     sizeText: 15,
                                                     textColor: .grayKit))
        let amountLabel = self.label(caption: "Valor",
                                     text: "R$ " + "\(amount)".currencyInputFormatting(),
                                     sizeCaption: 15,
                                     sizeText: 18,
                                     textColor: baseColor)
        amountLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        amountLabel.backgroundColor = self.baseColor.withAlphaComponent(0.3)
        
        self.stackView.addArrangedSubview(amountLabel)
        
        self.stackView.addArrangedSubview(self.horizontalView(caption: "Pagar com",
                                                              text: type,
                                                              textColor: self.baseColor))
        self.stackView.addArrangedSubview(self.horizontalView(caption: "Saldo disponível após \npagamento",
                                                              text: "R$ " + "\(balance - amount)".currencyInputFormatting()))
        self.stackView.addArrangedSubview(self.horizontalView(caption: "Vencimento",
                                                              text: dueDate.formatDate(format: "dd/MM/yyyy")))
        self.stackView.addArrangedSubview(self.horizontalView(caption: "Agendado para",
                                                              text: scheduledDueDate.formatDate(format: "dd/MM/yyyy"),
                                                              textColor: self.baseColor))
    }
    
    public func setContent(beneficiaryName: String,
                            scheduledDueDate: Date,
                            dueDate: Date,
                            navTitle: String,
                            paymentAmount: Double,
                            currentBalance: Double,
                            baseColor: UIColor,
                            paymentMessage: String,
                            payerName: String,
                            bankName: String,
                            barcode: String,
                            payWithType: String,
                            isPayment: Bool) {
        self.beneficiaryName = beneficiaryName
        self.scheduledDueDate = scheduledDueDate
        self.dueDate = dueDate
        self.navTitle = navTitle
        self.paymentAmount = paymentAmount
        self.currentBalance = currentBalance
        self.baseColor = baseColor
        self.payerName = payerName
        self.bankName = bankName
        self.barcode = barcode
        self.payWithType = payWithType
        self.isPayment = isPayment
        self.setupLayout()
    }
        
    private func horizontalView(caption: String, text: String, textColor: UIColor? = .darkGray) -> UIView {
        let container = UIStackView(frame: .zero)
        container.axis = .horizontal
        container.distribution = .fillProportionally

        container.heightAnchor.constraint(equalToConstant: .defaultArea).isActive = true
        
        let captionLabel = IPPaddingLabel(frame: .zero)
        captionLabel.text = caption
        captionLabel.font = UIFont.customFont(ofSize: 15, weight: .regular)
        captionLabel.textColor = .darkGray
        captionLabel.textAlignment = .left
        
        
        let textLabel = IPPaddingLabel(frame: .zero)
        textLabel.text = text
        textLabel.font = UIFont.customFont(ofSize: 15, weight: .bold)
        textLabel.textColor = textColor
        textLabel.textAlignment = .right
        
        container.addArrangedSubview(captionLabel)
        container.addArrangedSubview(textLabel)
        return container
    }

    @objc private func handleClick() {
        self.handleButtonClick?()
    }
    
    @objc private func closeAction() {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
