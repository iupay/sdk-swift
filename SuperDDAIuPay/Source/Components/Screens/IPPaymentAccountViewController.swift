//
//  IPPaymentAccountViewController.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 07/10/2020.
//

import UIKit
import Material

public class IPPaymentAccountViewController: UIViewController {

    public var handleSeeDetails: (() -> ())?
    public var handleCopyBarcode: ((String) -> ())?
    public var handleAccountDetails: (() -> ())?
    public var handleSeePDF: (() -> ())?
    public var handleRejectAccount: (() -> ())?
    public var handleAutoPaymentChange: ((Bool) -> ())?
    public var handleOptionsClick: (() -> ())?
    public var handlePaySchedule: (() -> ())?
    public var handleSeeHistory: (() -> ())?
    
    private lazy var lineChartView: LineChart = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(LineChart(frame: .zero))
    
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
        button.addTarget(self, action: #selector(self.seePDFAction), for: .touchUpInside)
        
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
    
    private lazy var payScheduleButton: UIView = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.customFont(ofSize: 16, weight: .bold)
        button.addTarget(self, action: #selector(self.payScheduleAction), for: .touchUpInside)
        button.setTitle("Pagar / Agendar", for: .normal)
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
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "HISTÓRICO DE PAGAMENTOS", attributes: underlineAttribute)
        label.attributedText = underlineAttributedString
        label.font = UIFont.customFont(ofSize: 13, weight: .regular)
        label.textColor = .darkGray
        label.centerYAnchor.constraint(equalTo: icon.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: .smallestMargin).isActive = true
        label.trailingAnchor.constraint(equalTo: $0.trailingAnchor).isActive = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.historyAction)))
        return $0
    }(UIView(frame: .zero))
    
    private lazy var baseCard = UIView(frame: .zero)
    private var payment: IPPayment?
    
    public init(payment: IPPayment,
                pdfAvailable: Bool,
                paymentHistoryEnabled: Bool,
                chartDataText: String,
                chartDataValue: String,
                chartLegend: String,
                chartData: [IPChartData],
                baseColor: UIColor) {
        super.init(nibName: nil, bundle: nil)
        self.setupContent(payment: payment,
                          pdfAvailable: pdfAvailable,
                          paymentHistoryEnabled: paymentHistoryEnabled,
                          chartDataText: chartDataText,
                          chartDataValue: chartDataValue,
                          chartLegend: chartLegend,
                          chartData: chartData,
                          baseColor: baseColor)
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
        
        self.scrollView.topAnchor.constraint(equalTo: self.companyLabel.bottomAnchor, constant: .smallMargin).isActive = true
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.scrollView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
    }
    
    public func setupContent(payment: IPPayment,
                             pdfAvailable: Bool,
                             paymentHistoryEnabled: Bool,
                             chartDataText: String,
                             chartDataValue: String,
                             chartLegend: String,
                             chartData: [IPChartData],
                             baseColor: UIColor) {
        self.payment = payment
        self.historyTitle.isHidden = !paymentHistoryEnabled
        let mainBtn = self.mainButton.subviews.compactMap({ $0 as? UIButton}).first
        mainBtn?.backgroundColor = pdfAvailable ? .clear : .lightGrayDarkerBg
        mainBtn?.setTitleColor(pdfAvailable ? baseColor : .white, for: .normal)
        mainBtn?.layer.borderColor = pdfAvailable ? baseColor.cgColor : UIColor.lightGrayDarkerBg.cgColor
        mainBtn?.layer.borderWidth = 2
        mainBtn?.setTitle(pdfAvailable ? "PDF da conta" : "PDF da conta não disponível",
                          for: .normal)
        
        let payScheduleButton = self.payScheduleButton.subviews.compactMap({ $0 as? UIButton}).first
        payScheduleButton?.backgroundColor = baseColor
        payScheduleButton?.setTitleColor(.white, for: .normal)
        
        let totalHeight: CGFloat =  232
        self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: totalHeight)
        
        self.companyLabel.text = payment.companyName
        self.companyLabel.textColor = baseColor
        self.logoImage.valleyImage(url: payment.companyLogo ?? "")
        let userAdd = payment.isUserAdded ?? false
        self.userBadge.image = UIImage.bundleImage(named: userAdd ? "user-check" : "user-x")?.tint(with: userAdd ? .systemGreen : .systemRed)
        
        let headerData = IPPaddingLabel(frame: .zero)
        headerData.translatesAutoresizingMaskIntoConstraints = false
        headerData.heightAnchor.constraint(equalToConstant: 130).isActive = true
        headerData.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        headerData.numberOfLines = 0
        let text = "CNPJ \(payment.cnpj ?? "--")<br>" +
            "Cartão \(payment.cardNumber ?? "--")<br><br>" +
            "\(payment.cardHolderName ?? "--")<br>" +
            "<b>\(payment.billDetails?.billDate?.formatDate(format: "MMM yyyy", fromFormat: "yyyy-mm") ?? "")</b><br>" +
            "Valor: <b>R$ \(String(describing: payment.billDetails?.value ?? 0.0).currencyInputFormatting(divide: false))</b><br>" +
            "Vencimento: <b>\(payment.billDetails?.dueDate?.formatDate(format: "dd MMM yyyy") ?? "")</b><br>"
        headerData.attributedText = text.convertHtml()

        self.stackView.addArrangedSubview(headerData)
        self.stackView.addArrangedSubview(self.barcodeView(barcode: payment.billDetails?.barCode ?? ""))
        self.stackView.addArrangedSubview(self.space())
        let chartview = self.chartView(data: chartData, caption: chartLegend, color: baseColor)
        chartview.backgroundColor = baseColor
        self.stackView.addArrangedSubview(chartview)
        self.stackView.addArrangedSubview(self.cellView(text: chartDataText, value: chartDataValue, color: baseColor))
        self.stackView.addArrangedSubview(self.mainButton)
        self.stackView.addArrangedSubview(self.viewWithSelector(payment: payment, color: baseColor))
        if payment.isAutomaticDebit == false {
            self.stackView.addArrangedSubview(self.payScheduleButton)
        }
        
        self.stackView.addArrangedSubview(self.sideButtons(color: baseColor))
        self.stackView.addArrangedSubview(self.historyTitle)
    }
    
    private func space() -> UIView {
        let space = UIView(frame: .zero)
        space.heightAnchor.constraint(equalToConstant: .smallMargin).isActive = true
        return space
    }
    
    private func viewWithSelector(payment: IPPayment, color: UIColor) -> UIView {
        
        let content = UIView(frame: .zero)
        
        content.translatesAutoresizingMaskIntoConstraints = false
        content.heightAnchor.constraint(equalToConstant: 50).isActive = true
        content.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        let textLabel = UILabel(frame: .zero)
        textLabel.numberOfLines = 0
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.customFont(ofSize: 15, weight: .regular)
        textLabel.textColor = .grayKit
        textLabel.text = payment.isAutomaticDebit ?? false ?  "Conta em débito automático no \(payment.automaticDebitBankName ?? "")" : "Pagamento automático no dia do vencimento"
        
        content.addSubview(textLabel)
        let toggle = Switch(state: .off, size: .medium)
        content.addSubview(toggle)
        
        textLabel.topAnchor.constraint(equalTo: content.topAnchor).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: .bigMediumMargin).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: toggle.leadingAnchor, constant: -4).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
        
        
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor).isActive = true
        toggle.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -.bigMediumMargin).isActive = true
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.buttonOnColor = color
        toggle.buttonDiameter = .mediumMargin
        toggle.buttonOffColor = .darkGray
        toggle.trackOffColor = UIColor.darkGray.withAlphaComponent(0.7)
        toggle.trackOnColor = color.withAlphaComponent(0.7)
        toggle.trackThickness = 7.0
        toggle.addTarget(self, action: #selector(self.autoPaymentChangeAction(sender:)), for: .valueChanged)
        
        toggle.isHidden = self.payment?.isAutomaticDebit ?? false
        return content
    }
    
    private func sideButtons(color: UIColor) -> UIView {
        let container = UIView(frame: .zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        container.heightAnchor.constraint(equalToConstant: .defaultArea).isActive = true
        
        let rejectButton = UIButton(frame: .zero)
        rejectButton.translatesAutoresizingMaskIntoConstraints = false
        rejectButton.layer.cornerRadius = 8
        rejectButton.layer.borderColor = color.cgColor
        rejectButton.layer.borderWidth = 2
        rejectButton.setTitleColor(color, for: .normal)
        rejectButton.setTitle("Recusar a conta", for: .normal)
        rejectButton.titleLabel?.font = UIFont.customFont(ofSize: 14, weight: .bold)
        rejectButton.addTarget(self, action: #selector(self.rejectAction), for: .touchUpInside)
        
        let detailsButton = UIButton(frame: .zero)
        detailsButton.translatesAutoresizingMaskIntoConstraints = false
        detailsButton.setTitle("Ver detalhes da conta", for: .normal)
        detailsButton.titleLabel?.font = UIFont.customFont(ofSize: 13, weight: .bold)
        detailsButton.setTitleColor(color, for: .normal)
        detailsButton.layer.cornerRadius = 8
        detailsButton.layer.borderColor = color.cgColor
        detailsButton.layer.borderWidth = 2
        detailsButton.addTarget(self, action: #selector(self.seeDetailsAction), for: .touchUpInside)
        
        container.addSubview(rejectButton)
        container.addSubview(detailsButton)
        
        rejectButton.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        rejectButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: .bigMediumMargin).isActive = true
        rejectButton.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        rejectButton.trailingAnchor.constraint(equalTo: detailsButton.leadingAnchor, constant: -.smallestMargin).isActive = true
        
        detailsButton.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        detailsButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -.bigMediumMargin).isActive = true
        detailsButton.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        detailsButton.widthAnchor.constraint(equalTo: rejectButton.widthAnchor).isActive = true
        return container
    }
    
    private func barcodeView(barcode: String) -> UIView {
        let container = UIView(frame: .zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        let label = self.label(caption: "Código de Barras:", text: barcode, sizeCaption: 15, sizeText: 13, textColor: .grayKit, breakLine: true, underlined: false)
        label.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(label)
        
        container.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        container.heightAnchor.constraint(equalToConstant: 60).isActive = true
        label.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        let icon = UIImageView(image: UIImage.bundleImage(named: "copy")?.tint(with: .grayKit))
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFill
        container.addSubview(icon)

        icon.widthAnchor.constraint(equalToConstant: .smallMargin).isActive = true
        icon.heightAnchor.constraint(equalToConstant: .smallMargin).isActive = true
        
        icon.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 154).isActive = true
        icon.topAnchor.constraint(equalTo: label.topAnchor, constant: 6).isActive = true
        
        container.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.copyBarcodeAction)))
        return container
    }
    
    private func chartView(data: [IPChartData], caption: String, color: UIColor) -> UIView {
        let chart = UIView(frame: .zero)
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = caption
        label.font = UIFont.customFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        chart.heightAnchor.constraint(equalToConstant: 210).isActive = true
        
        chart.addSubview(self.lineChartView)
        chart.addSubview(label)
        
        label.topAnchor.constraint(equalTo: chart.topAnchor, constant: .mediumMargin).isActive = true
        label.leadingAnchor.constraint(equalTo: chart.leadingAnchor, constant: .bigMediumMargin).isActive = true
        label.trailingAnchor.constraint(equalTo: chart.trailingAnchor, constant: -.bigMediumMargin).isActive = true
        label.heightAnchor.constraint(equalToConstant: .bigMediumMargin).isActive = true
        
        self.lineChartView.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        self.lineChartView.leadingAnchor.constraint(equalTo: chart.leadingAnchor).isActive = true
        self.lineChartView.trailingAnchor.constraint(equalTo: chart.trailingAnchor).isActive = true
        self.lineChartView.bottomAnchor.constraint(equalTo: chart.bottomAnchor).isActive = true
        self.lineChartView.animateDots = true
        self.lineChartView.showDots = true
        self.lineChartView.innerColor = color

        let result: [PointEntry] = data.map({
            PointEntry(value: Int($0.value), label: $0.label)
        })
        
        self.lineChartView.dataEntries = result
        self.lineChartView.isCurved = true
        
        return chart
    }
   
    private func cellView(text: String, value: String, color: UIColor) -> UIView {
        let content = UIView(frame: .zero)
        
        content.backgroundColor = color.withAlphaComponent(0.3)
        content.translatesAutoresizingMaskIntoConstraints = false
        content.heightAnchor.constraint(equalToConstant: 50).isActive = true
        content.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        let textLabel = UILabel(frame: .zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.customFont(ofSize: 15, weight: .bold)
        textLabel.textColor = color
        textLabel.text = text
        
        content.addSubview(textLabel)
        
        textLabel.topAnchor.constraint(equalTo: content.topAnchor).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: .bigMediumMargin).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
        
        let price = IPPaddingLabel(text: value, fontSize: 15, weight: .bold, textColor: color)
        price.translatesAutoresizingMaskIntoConstraints = false
        price.textAlignment = .right
        content.addSubview(price)
        price.trailingAnchor.constraint(equalTo: content.trailingAnchor).isActive = true
        price.topAnchor.constraint(equalTo: content.topAnchor).isActive = true
        price.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
        price.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2).isActive = true
        
        return content
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
    
    @objc private func autoPaymentChangeAction(sender: Switch) {
        self.handleAutoPaymentChange?(sender.isOn)
    }
    
    @objc private func seePDFAction() {
        self.handleSeePDF?()
    }
    
    @objc private func copyBarcodeAction() {
        self.handleCopyBarcode?(self.payment?.billDetails?.barCode ?? "")
    }
    
    @objc private func payScheduleAction() {
        self.handlePaySchedule?()
    }
    
    @objc private func historyAction() {
        self.handleSeeHistory?()
    }
    
    @objc private func rejectAction() {
        self.handleRejectAccount?()
    }
    
    @objc private func seeDetailsAction() {
        self.handleSeeDetails?()
    }
}
