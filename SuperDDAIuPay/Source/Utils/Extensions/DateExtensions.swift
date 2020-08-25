//
//  DateExtensions.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 14/08/2020.
//

import Foundation

extension Date {
    func getNextMonth(byAdding count: Int) -> Date? {
        return Calendar.current.date(byAdding: .month, value: count, to: self)
    }

    func getPreviousMonth(byDecreasing count: Int) -> Date? {
        return Calendar.current.date(byAdding: .month, value: -count, to: self)
    }
    
    var getMonthNumber: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    var getDay: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    var getMonthName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt-BR")
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: self)
    }
}
