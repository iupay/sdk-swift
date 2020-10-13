//
//  RDBeneficiaryDetailsViewController.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 07/10/2020.
//

import UIKit

public class IPBeneficiaryDetailsViewController: UIViewController {

    public var handleSeeDetails: (() -> ())?
    public var handleViewCard: (() -> ())?
    public var handleOptionsClick: (() -> ())?
    
    private lazy var backButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage.bundleImage(named: "left-arrow"), for: .normal)
        $0.addTarget(self, action: #selector(self.closeAction), for: .touchUpInside)
        $0.tintColor = .darkGray
        return $0
    }(UIButton(frame: .zero))
    
    private lazy var logoImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView(frame: .zero))
    
    private lazy var dotsButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage.bundleImage(named: "dots-menu"), for: .normal)
        $0.addTarget(self, action: #selector(self.optionsAction), for: .touchUpInside)
        $0.tintColor = .darkGray
        return $0
    }(UIButton(frame: .zero))
    
    private lazy var companyLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.customFont(ofSize: 15, weight: .semibold)
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var iupayBadge: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage.bundleImage(named: "iupay-logo")
        return $0
    }(UIImageView(frame: .zero))
    
    private lazy var userBadge: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView(frame: .zero))
    
    private lazy var scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView(frame: .zero))
    
    private lazy var stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .top
        return $0
    }(UIStackView(frame: .zero))
    
    private lazy var mainButton: UIView = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.customFont(ofSize: 16, weight: .bold)
        button.addTarget(self, action: #selector(self.seeDetailsAction), for: .touchUpInside)
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addSubview(button)
        
        button.centerYAnchor.constraint(equalTo: $0.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: .bigMediumMargin).isActive = true
        button.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: -.bigMediumMargin).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 70).isActive = true
        $0.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        return $0
    }(UIView(frame: .zero))
    
    private lazy var historyTitle: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .lightGrayKitBg
        $0.heightAnchor.constraint(equalToConstant: 64).isActive = true
        $0.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        let icon = UIImageView(image: UIImage.bundleImage(named: "report"))
        icon.translatesAutoresizingMaskIntoConstraints = false
        $0.addSubview(icon)
        icon.heightAnchor.constraint(equalToConstant: .bigMediumMargin).isActive = true
        icon.widthAnchor.constraint(equalToConstant: .bigMediumMargin).isActive = true
        icon.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: .bigMediumMargin).isActive = true
        icon.centerYAnchor.constraint(equalTo: $0.centerYAnchor).isActive = true
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        $0.addSubview(label)
        label.textAlignment = .left
        label.text = "Histórico de Pagamentos"
        label.font = UIFont.customFont(ofSize: 15, weight: .regular)
        label.textColor = .darkGray
        label.centerYAnchor.constraint(equalTo: icon.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: .smallMargin).isActive = true
        label.trailingAnchor.constraint(equalTo: $0.trailingAnchor).isActive = true
        return $0
    }(UIView(frame: .zero))
    
    private lazy var baseCard = UIView(frame: .zero)
    
    init(payment: IPPayment, baseColor: UIColor) {
        super.init(nibName: nil, bundle: nil)
        self.setupContent(payment: payment, baseColor: baseColor)
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
    
    public func setupContent(payment: IPPayment, baseColor: UIColor) {
        
        let mainBtn = self.mainButton.subviews.compactMap({ $0 as? UIButton}).first
        self.mainButton.backgroundColor = .clear
        mainBtn?.setTitleColor(baseColor, for: .normal)
        mainBtn?.layer.borderColor = baseColor.cgColor
        mainBtn?.layer.borderWidth = 2
        mainBtn?.setTitle("Ver detalhes do beneficiário", for: .normal)
        
        let totalHeight: CGFloat = CGFloat((payment.paymentHistory?.count ?? 0) + 1) * 64 + 292
//        self.stackView.heightAnchor.constraint(equalToConstant: totalHeight).isActive = true
        self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: totalHeight)
        
        self.companyLabel.text = payment.companyName
        self.companyLabel.textColor = baseColor
        self.logoImage.valleyImage(url: payment.companyLogo ?? "")
        let userAdd = payment.isUserAdded ?? false
        self.userBadge.image = UIImage.bundleImage(named: userAdd ? "user-check" : "user-x")?.tint(with: userAdd ? .systemGreen : .systemRed)
        
        let cnpjLabel = self.label(caption: "CNPJ ", text: payment.cnpj ?? "", sizeCaption: 15, sizeText: 15, textColor: .darkGray, breakLine: false)
        cnpjLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        cnpjLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true

        self.stackView.addArrangedSubview(cnpjLabel)
        
        let card = IPPaddingLabel(text: "Cartão" + (payment.cardNumber ?? ""),
                                  fontSize: 15,
                                  weight: .regular,
                                  textColor: .darkGray)
        card.heightAnchor.constraint(equalToConstant: 21).isActive = true
        card.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        self.stackView.addArrangedSubview(card)
        
        self.stackView.addArrangedSubview(self.space())
        
        let automaticLabel = self.label(caption: "Pagamento Automático ", text: (payment.autoPayment ?? false) ? "Ativado" : "Desativado", sizeCaption: 15, sizeText: 15, textColor: baseColor, breakLine: false, underlined: true)
        automaticLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        automaticLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        self.stackView.addArrangedSubview(automaticLabel)
        
        let authLimitLabel = self.label(caption: "Limite de Autorização ", text: (payment.authorizedLimit ?? false) ? "Ativado" : "Desativado", sizeCaption: 15, sizeText: 15, textColor: baseColor, breakLine: false, underlined: true)
        authLimitLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        authLimitLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        self.stackView.addArrangedSubview(authLimitLabel)
        
        self.baseCard.backgroundColor = baseColor
        self.baseCard.translatesAutoresizingMaskIntoConstraints = false
        self.baseCard.heightAnchor.constraint(equalToConstant: 96).isActive = true
        self.baseCard.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        let cardLabel = label(caption: payment.cardHolderName ?? "", text: "Acessar Cartão", sizeCaption: 15, sizeText: 15, textColor: baseColor, breakLine: true, underlined: false)

        cardLabel.backgroundColor = .white
        cardLabel.layer.cornerRadius = 8
        cardLabel.clipsToBounds = true
        cardLabel.translatesAutoresizingMaskIntoConstraints = false
        self.baseCard.addSubview(cardLabel)
        self.baseCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewCardAction)))
        
        cardLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        cardLabel.leadingAnchor.constraint(equalTo: baseCard.leadingAnchor, constant: .bigMediumMargin).isActive = true
        cardLabel.trailingAnchor.constraint(equalTo: baseCard.trailingAnchor, constant: -.bigMediumMargin).isActive = true
        cardLabel.centerYAnchor.constraint(equalTo: baseCard.centerYAnchor).isActive = true
        
        self.stackView.addArrangedSubview(self.space())
        self.stackView.addArrangedSubview(self.baseCard)
        self.stackView.addArrangedSubview(self.mainButton)
        self.stackView.addArrangedSubview(self.historyTitle)
        
        payment.paymentHistory?.forEach({ (item) in
            self.stackView.addArrangedSubview(self.cellView(item: item))
        })
    }
    
    private func space() -> UIView {
        let space = UIView(frame: .zero)
        space.heightAnchor.constraint(equalToConstant: .smallMargin).isActive = true
        return space
    }
    
    private func setupConstraints() {
        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.logoImage)
        self.view.addSubview(self.dotsButton)
        self.view.addSubview(self.companyLabel)
        self.view.addSubview(self.iupayBadge)
        self.view.addSubview(self.userBadge)
        self.scrollView.addSubview(self.stackView)
                
        self.backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: .mediumMargin).isActive = true
        self.backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .mediumMargin).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: .bigMediumMargin).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: .bigMediumMargin).isActive = true
        
        self.logoImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.logoImage.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor).isActive = true
        self.logoImage.heightAnchor.constraint(equalToConstant: .largeMargin).isActive = true
        self.logoImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.dotsButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -.mediumMargin).isActive = true
        self.dotsButton.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor).isActive = true
        self.dotsButton.heightAnchor.constraint(equalToConstant: .bigMediumMargin).isActive = true
        self.dotsButton.widthAnchor.constraint(equalToConstant: .bigMediumMargin).isActive = true
        
        self.companyLabel.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: .smallestMargin).isActive = true
        self.companyLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .bigMediumMargin).isActive = true
        self.companyLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -.bigMediumMargin).isActive = true
        self.companyLabel.heightAnchor.constraint(equalToConstant: .largeMargin).isActive = true
        
        self.userBadge.heightAnchor.constraint(equalToConstant: .mediumMargin).isActive = true
        self.userBadge.widthAnchor.constraint(equalToConstant: .mediumMargin).isActive = true
        self.userBadge.centerYAnchor.constraint(equalTo: self.companyLabel.centerYAnchor).isActive = true
        self.userBadge.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -.bigMediumMargin).isActive = true
        
        self.iupayBadge.heightAnchor.constraint(equalToConstant: .mediumMargin).isActive = true
        self.iupayBadge.widthAnchor.constraint(equalToConstant: .mediumMargin).isActive = true
        self.iupayBadge.centerYAnchor.constraint(equalTo: self.companyLabel.centerYAnchor).isActive = true
        self.iupayBadge.trailingAnchor.constraint(equalTo: self.userBadge.leadingAnchor, constant: -.smallestMargin).isActive = true
        
        self.scrollView.topAnchor.constraint(equalTo: self.companyLabel.bottomAnchor, constant: .bigMediumMargin).isActive = true
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.scrollView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
    }
    
    private func cellView(item: IPPaymentHistory) -> UIView {
        let cell = UIView(frame: .zero)
        cell.backgroundColor = .lightGrayKitBg
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.heightAnchor.constraint(equalToConstant: 62).isActive = true
        cell.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        let content = UIView(frame: .zero)
        cell.addSubview(content)
        
        content.backgroundColor = .white
        content.translatesAutoresizingMaskIntoConstraints = false
        content.heightAnchor.constraint(equalToConstant: 50).isActive = true
        content.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        content.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
        content.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
        
        let textLabel = UILabel(frame: .zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.customFont(ofSize: 15, weight: .regular)
        textLabel.textColor = .darkGray
        textLabel.numberOfLines = 2
        textLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2).isActive = true
        let attText = NSMutableAttributedString(string: item.date.formatDate(format: "MMMM yyyy", fromFormat: "yyyy-MM"))
        
        let captionAttribute = [
            NSAttributedString.Key.font: UIFont.customFont(ofSize: 13, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ]
         
         let openText = NSAttributedString(string: "\nem aberto", attributes: captionAttribute as [NSAttributedString.Key : Any])
        if let isOpen = item.isOpen, isOpen == true {
            attText.append(openText)
        }
        textLabel.attributedText = attText
        content.addSubview(textLabel)
        
        textLabel.topAnchor.constraint(equalTo: content.topAnchor).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: .mediumMargin).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
        
        let price = self.label(caption: "R$ ", text: "\(item.value)".currencyInputFormatting(), sizeCaption: 12, sizeText: 15, breakLine: false)
        price.translatesAutoresizingMaskIntoConstraints = false
        price.textAlignment = .right
        content.addSubview(price)
        price.trailingAnchor.constraint(equalTo: content.trailingAnchor).isActive = true
        price.topAnchor.constraint(equalTo: content.topAnchor).isActive = true
        price.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
        price.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor).isActive = true
        return cell
    }
    
    @objc private func closeAction() {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
 
    @objc private func optionsAction() {
        self.handleOptionsClick?()
    }
    
    @objc private func viewCardAction() {
        self.handleViewCard?()
    }
    
    @objc private func seeDetailsAction() {
        self.handleSeeDetails?()
    }
}
