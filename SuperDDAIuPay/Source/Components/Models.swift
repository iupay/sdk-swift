//
//  Models.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 19/08/2020.
//

// MARK: - CardItem
public struct CardItem {
    var barColor: UIColor
    var cardTitle: String?
    var dueDate: Date
    var isPaid: Bool
    var type: BaseCardType
    var amount: Double
    var isLocked: Bool
    
    public init(barColor: UIColor,
                cardTitle: String?,
                dueDate: Date,
                isPaid: Bool,
                type: BaseCardType,
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


// MARK: - BaseCardType ENUM
public enum BaseCardType {
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

// MARK: - Payment
public struct Payment: Codable {
    let companyName, cnpj, cardNumber, companyLogo, cardHolderName, cardHolderAddress: String?
    let autoPayment, isAutomaticDebit, isFromIuPay, isUserAdded, authorizedLimit: Bool?
    let paymentHistory: [PaymentHistory]?
    let billDetails: BillDetails?
}

// MARK: - BillDetails
public struct BillDetails: Codable {
    let barCode, billDate, dueDate, emissionDate: String?
    let interestInstallmentFine, interestInstallmentRate, interestInstallmentRateCET, interestRate: Int?
    let interestRateCET: Double?
    let minimumPaymentValue, totalLimitValue, totalWithdrawLimitValue: Int?
    let value: Double?
}

// MARK: - PaymentHistory
public struct PaymentHistory: Codable {
    let date: String
    let value: Double
}
