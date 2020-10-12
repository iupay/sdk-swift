//
//  Models.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 19/08/2020.
//

// MARK: - CardItem
public struct IPCardItem {
    var barColor: UIColor
    var cardTitle: String?
    var dueDate: Date
    var isPaid: Bool?
    var type: IPBaseCardType
    var amount: Double
    var isLocked: Bool
    
    public init(barColor: UIColor,
                cardTitle: String?,
                dueDate: Date,
                isPaid: Bool? = nil,
                type: IPBaseCardType,
                amount: Double,
                isLocked: Bool) {
        self.barColor = barColor
        self.cardTitle = cardTitle
        self.dueDate = dueDate
        self.isPaid = isPaid
        self.type = type
        self.amount = amount
        self.isLocked = isLocked
    }
    
    func formattedDate() -> String {
        return "\(self.dueDate.getDay) \(self.dueDate.getMonthName())".uppercased()
    }
}


// MARK: - IPBaseCardType ENUM
public enum IPBaseCardType {
    case netflix
    case nubank
    case lightbill(flag: BillFlagStatus)
    case spotify
    case standard(imageUrl: String)
    case locked
    
    var image: UIImage? {
        switch self {
        case .netflix:
            return UIImage.bundleImage(named: "netflix-logo")
        case .spotify:
            return UIImage.bundleImage(named: "spotify-logo")
        case .nubank:
            return UIImage.bundleImage(named: "nubank-logo")
        case .lightbill:
            return UIImage.bundleImage(named: "lightbulb")
        case .locked:
            return UIImage.bundleImage(named: "lock")
        default:
            return nil
        }
    }
    
    public enum BillFlagStatus {
        case green
        case yellow
        case red
        case none
        
        var color: UIColor {
            switch self {
            case .green: return .systemGreen
            case .yellow: return .yellowKit
            case .red: return .redKit
            default: return .clear
            }
        }
    }
}

// MARK: - IPPayment
public struct IPPayment: Codable {
    let companyName, cnpj, cardNumber, companyLogo, cardHolderName, cardHolderAddress, automaticDebitBankName: String?
    let autoPayment, isAutomaticDebit, isFromIuPay, isUserAdded, authorizedLimit: Bool?
    let paymentHistory: [IPPaymentHistory]?
    let billDetails: IPBillDetails?
}

// MARK: - IPBillDetails
public struct IPBillDetails: Codable {
    let barCode, billDate, dueDate, emissionDate: String?
    let interestInstallmentFine, interestInstallmentRate, interestInstallmentRateCET, interestRate: Int?
    let interestRateCET: Double?
    let minimumPaymentValue, totalLimitValue, totalWithdrawLimitValue: Int?
    let value: Double?
}

// MARK: - IPPaymentHistory
public struct IPPaymentHistory: Codable {
    let date: String
    let value: Double
    let isOpen: Bool?
    
    public init(date: String, value: Double, isOpen: Bool) {
        self.date = date
        self.value = value
        self.isOpen = isOpen
    }
}

// MARK: - IPChartData
public struct IPChartData: Codable {
    let label: String
    let value: Double
    
    public init(label: String, value: Double) {
        self.label = label
        self.value = value
    }
}
