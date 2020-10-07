//
//  ReceiptViewController.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 07/10/2020.
//

import UIKit

public class ReceiptViewController: UIViewController {

    @objc public var handleButtonClick: (() -> ())?
    
    private var cedentName: String?
    private var cnpj: String?
    private var payerName: String?
    private var barcode: String?
    private var dueDate: Date?
    private var paidDate: String?
    private var value: Double?
    private var discount: Double?
    private var interest: Double?
    private var fine: Double?
    private var chargedValue: Double?
    private var authCode: String?
    private var baseColor: UIColor?
    
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
    
    init(cedentName: String,
         cnpj: String,
         payerName: String,
         barcode: String,
         dueDate: Date,
         paidDate: String,
         value: Double,
         discount: Double,
         interest: Double,
         fine: Double,
         chargedValue: Double,
         authCode: String,
         baseColor: UIColor) {
        
        super.init(nibName: nil, bundle: nil)
        self.setContent
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
        self.mainButton.backgroundColor = self.baseColor
        self.mainButton.setTitleColor(.white, for: .normal)
        self.mainButton.setTitle("Compartilhar Comprovante", for: .normal)
        
    }
    
    public func setContent(cedentName: String,
                           cnpj: String,
                           payerName: String,
                           barcode: String,
                           dueDate: Date,
                           paidDate: String,
                           value: Double,
                           discount: Double,
                           interest: Double,
                           fine: Double,
                           chargedValue: Double,
                           authCode: String,
                           baseColor: UIColor) {
        self.cedentName = cedentName
        self.cnpj = cnpj
        self.payerName = payerName
        self.barcode = barcode
        self.dueDate = dueDate
        self.paidDate = paidDate
        self.value = value
        self.discount = discount
        self.interest = interest
        self.fine = fine
        self.chargedValue = chargedValue
        self.authCode = authCode
        self.baseColor = baseColor
        self.setupLayout()
    }
    
    private func label(caption: String,
                       text: String,
                       sizeCaption: CGFloat,
                       sizeText: CGFloat,
                       textColor: UIColor? = .darkGray) -> PaddingLabel {
       let captionAttribute = [
            NSAttributedString.Key.font: UIFont.customFont(ofSize: sizeCaption, weight: .regular),
            NSAttributedString.Key.foregroundColor: textColor
        ]
        
        let caption = NSAttributedString(string: caption + "\n", attributes: captionAttribute as [NSAttributedString.Key : Any])
        
        let focusedAttribute = [
            NSAttributedString.Key.font: UIFont.customFont(ofSize: sizeText, weight: .bold),
            NSAttributedString.Key.foregroundColor: textColor
        ]
        
        let totalAmount = NSAttributedString(string: text, attributes: focusedAttribute as [NSAttributedString.Key : Any])
        
        let combination = NSMutableAttributedString()
        combination.append(caption)
        combination.append(totalAmount)
        
        let label = PaddingLabel(frame: .zero)
        label.attributedText = combination
        label.numberOfLines = 0
        
        return label
    }
        
    private func horizontalView(caption: String, text: String, textColor: UIColor? = .darkGray) -> UIView {
        let container = UIStackView(frame: .zero)
        container.axis = .horizontal
        container.distribution = .fillProportionally

        container.heightAnchor.constraint(equalToConstant: .defaultArea).isActive = true
        
        let captionLabel = PaddingLabel(frame: .zero)
        captionLabel.text = caption
        captionLabel.font = UIFont.customFont(ofSize: 15, weight: .regular)
        captionLabel.textColor = .darkGray
        captionLabel.textAlignment = .left
        
        
        let textLabel = PaddingLabel(frame: .zero)
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
