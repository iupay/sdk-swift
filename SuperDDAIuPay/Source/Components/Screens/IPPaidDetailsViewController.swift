//
//  IPPaidDetailsViewController.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 05/10/2020.
//

import UIKit

/**
 Screen for paid billds
 
 ### Usage: ###
``` 
 
 let paidVc = IPPaidDetailsViewController(beneficiaryName: "John Doe",
                                         paidDate: Date(),
                                         dueDate: Date(),
                                         navTitle: "CERJ",
                                         imageUrl: "https://myimageurl.com/image.png",
                                         paymentAmount: 223.24,
                                         baseColor: .systemRed,
                                         receiptAvailable: true,
                                         paymentMessage: "Sua conta está paga")
 
 // Alternatively, when using with storyboard/xibs, component can be configured the following way:
 paidVC.setContent(beneficiaryName: "John Doe",
                   paidDate: Date(),
                   dueDate: Date(),
                   navTitle: "CERJ",
                   imageUrl: "https://myimageurl.com/image.png",
                   paymentAmount: 223.24,
                   baseColor: .systemRed,
                   receiptAvailable: true,
                   paymentMessage: "Sua conta está paga")
 
 beneficiaryDetailsController.handleReceiptClick = {
     // Action for receipt button
 }
```
*/
public class IPPaidDetailsViewController: UIViewController {

    @objc public var handleReceiptClick: (() -> ())?
    
    private var beneficiaryName, navTitle, imageUrl, paymentMessage: String?
    private var paidDate: Date?
    private var dueDate: Date?
    private var paymentAmount: Double?
    private var baseColor: UIColor = .red
    private var receiptAvailable: Bool = false
    
    private lazy var backButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage.bundleImage(named: "left-arrow"), for: .normal)
        $0.addTarget(self, action: #selector(self.closeAction), for: .touchUpInside)
        $0.tintColor = .darkGray
        return $0
    }(UIButton(frame: .zero))
    
    private lazy var image: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.tintColor = .darkGray
        return $0
    }(UIImageView(frame: .zero))
    
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
    
    private lazy var receiptButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 2
        $0.titleLabel?.font = UIFont.customFont(ofSize: 16, weight: .bold)
        $0.setTitle("Ver Comprovante", for: .normal)
        $0.addTarget(self, action: #selector(self.handleClick), for: .touchUpInside)
        return $0
    }(UIButton(frame: .zero))
    
    public init(beneficiaryName: String,
                paidDate: Date,
                dueDate: Date,
                navTitle: String,
                imageUrl: String,
                paymentAmount: Double,
                baseColor: UIColor,
                receiptAvailable: Bool,
                paymentMessage: String) {
        
        super.init(nibName: nil, bundle: nil)
        self.setContent(beneficiaryName: beneficiaryName,
                        paidDate: paidDate,
                        dueDate: dueDate,
                        navTitle: navTitle,
                        imageUrl: imageUrl,
                        paymentAmount: paymentAmount,
                        baseColor: baseColor,
                        receiptAvailable: receiptAvailable,
                        paymentMessage: paymentMessage)
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
        self.view.addSubview(self.receiptButton)
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.image)
        self.view.addSubview(self.titleLabel)
        
        self.backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: .smallMargin).isActive = true
        self.backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .mediumMargin).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: .bigMediumMargin).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: .bigMediumMargin).isActive = true
        
        self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.titleLabel.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: .largeMargin).isActive = true
       
        self.image.trailingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor, constant: -.smallestMargin).isActive = true
        self.image.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor).isActive = true
        self.image.heightAnchor.constraint(equalToConstant: .largeMargin).isActive = true
        self.image.widthAnchor.constraint(equalToConstant: .largeMargin).isActive = true
        
        self.stackView.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: .bigMediumMargin).isActive = true
        self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.stackView.heightAnchor.constraint(equalToConstant: 292).isActive = true
        
        self.receiptButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: .mediumMargin).isActive = true
        self.receiptButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .bigMediumMargin).isActive = true
        self.receiptButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -.bigMediumMargin).isActive = true
        self.receiptButton.heightAnchor.constraint(equalToConstant: .defaultArea).isActive = true
    }
    
    private func setupLayout() {
        guard
            let paidDate = self.paidDate,
            let dueDate = self.dueDate,
            let name = self.beneficiaryName,
            let message = self.paymentMessage,
            let amount = self.paymentAmount,
            let imageURL = self.imageUrl
        else { return }
        
        self.image.valleyImage(url: imageURL)
        self.titleLabel.text = navTitle
        self.stackView.addArrangedSubview(self.label(text: name,
                                                     size: 15,
                                                     weight: .bold,
                                                     textColor: .grayKit,
                                                     height: .defaultArea))
        
        self.stackView.addArrangedSubview(self.label(text: paidDate.formatDate(format: "MMMM yyyy"),
                                                     size: 15,
                                                     weight: .bold,
                                                     textColor: .grayKit,
                                                     height: .defaultArea))
        
        self.stackView.addArrangedSubview(self.label(text: "Vencimento",
                                                     size: 13,
                                                     weight: .regular,
                                                     textColor: .grayKit))
        
        self.stackView.addArrangedSubview(self.label(text: dueDate.formatDate(format: "dd/MM/yyyy"),
                                                     size: 15,
                                                     weight: .bold,
                                                     textColor: .grayKit))
        self.stackView.addArrangedSubview(self.space())
        
        self.stackView.addArrangedSubview(self.label(text: "Valor",
                                                     size: 13,
                                                     weight: .regular,
                                                     textColor: .grayKit))
        self.stackView.addArrangedSubview(self.label(text: "R$ " + "\(amount)".currencyInputFormatting(),
                                                     size: 15,
                                                     weight: .bold,
                                                     textColor: .grayKit))
        self.stackView.addArrangedSubview(self.space())
        
        let label = self.label(text: message,
                               size: 18,
                               weight: .bold,
                               textColor: self.baseColor,
                               height: 80)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = self.baseColor.withAlphaComponent(0.3)
        self.stackView.addArrangedSubview(label)
        label.widthAnchor.constraint(equalTo: self.stackView.widthAnchor).isActive = true
        
        
        self.receiptButton.layer.borderColor = self.receiptAvailable ? self.baseColor.cgColor : UIColor.lightGrayDarkerBg.cgColor
        self.receiptButton.setTitleColor(self.receiptAvailable ? self.baseColor : .white, for: .normal)
        self.receiptButton.backgroundColor = self.receiptAvailable ? .clear : .lightGrayDarkerBg
    }
    
    public func setContent(beneficiaryName: String,
                            paidDate: Date,
                            dueDate: Date,
                            navTitle: String,
                            imageUrl: String,
                            paymentAmount: Double,
                            baseColor: UIColor,
                            receiptAvailable: Bool,
                            paymentMessage: String) {
        self.beneficiaryName = beneficiaryName
        self.paidDate = paidDate
        self.dueDate = dueDate
        self.navTitle = navTitle
        self.imageUrl = imageUrl
        self.paymentAmount = paymentAmount
        self.baseColor = baseColor
        self.receiptAvailable = receiptAvailable
        self.paymentMessage = paymentMessage
        self.setupLayout()
    }
    
    private func label(text: String,
                       size: CGFloat,
                       weight: UIFont.Weight,
                       textColor: UIColor,
                       height: CGFloat? = nil) -> IPPaddingLabel {
        let label = IPPaddingLabel(text: text, fontSize: size, weight: weight, textColor: textColor)
        label.text = text
        label.numberOfLines = 0
        if let height = height {
            label.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        return label
    }
    
    private func space() -> UIView {
        let space = UIView(frame: .zero)
        space.heightAnchor.constraint(equalToConstant: .bigMediumMargin).isActive = true
        return space
    }
    
    @objc private func handleClick() {
        self.handleReceiptClick?()
    }
    
    @objc private func closeAction() {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
