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
    
    public init(barColor: UIColor,
                cardTitle: String?,
                dueDate: Date,
                isPaid: Bool,
                type: BaseCardType,
                amount: Double) {
        self.barColor = barColor
        self.cardTitle = cardTitle
        self.dueDate = dueDate
        self.isPaid = isPaid
        self.type = type
        self.amount = amount
    }
    
    func formattedDate() -> String {
        return "\(self.dueDate.getDay) \(self.dueDate.getMonthName)".uppercased()
    }
}


// MARK: BaseCardType ENUM
public enum BaseCardType {
    case netflix
    case nubank
    case lightbill(flag: BillFlagStatus)
    case spotify
    case standard(imageUrl: String)
    
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
