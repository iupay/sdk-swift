extension String {

    // formatting text for currency textField
    func currencyInputFormatting(divide: Bool = true) -> String {

        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "pt-BR")
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2

        var amountWithPrefix = self

        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")

        let double = (amountWithPrefix as NSString).doubleValue
        guard divide else { return formatter.string(from: NSNumber(value: double)) ?? "" }
        number = NSNumber(value: (double / 100))

        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }

        return formatter.string(from: number) ?? ""
    }
    
    /// Convert HTML to NSAttributedString
    public func convertHtml(textColor: UIColor = .darkGray) -> NSAttributedString {
        guard let data = data(using: .utf16) else { return NSAttributedString() }
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            let string = NSMutableAttributedString(attributedString: attributedString)

            // Apply text color
            string.addAttributes([.foregroundColor: textColor], range: NSRange(location: 0, length: attributedString.length))

            // Update fonts
            let regularFont =  UIFont.customFont(ofSize: 15, weight: .regular) // DEFAULT FONT (REGUALR)
            let boldFont =  UIFont.customFont(ofSize: 15, weight: .bold) // BOLD FONT
            /// add other fonts if you have them

            string.enumerateAttribute(.font, in: NSMakeRange(0, attributedString.length), options: NSAttributedString.EnumerationOptions(rawValue: 0), using: { (value, range, stop) -> Void in

                /// Update to our font
                // Bold font
                if let oldFont = value as? UIFont, oldFont.fontName.lowercased().contains("bold") {
                    string.removeAttribute(.font, range: range)
                    string.addAttribute(.font, value: boldFont, range: range)
                }
                // Default font
                else {
                    string.addAttribute(.font, value: regularFont, range: range)
                }
            })
            return string
        }
        return NSAttributedString()
    }
    
    func formatDate(format: String, fromFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = fromFormat

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "pt-BR")
        dateFormatterPrint.dateFormat = format

        if let date = dateFormatterGet.date(from: self) {
            return dateFormatterPrint.string(from: date).uppercased()
        } else {
           print("There was an error decoding the string")
        }
        
        return ""
    }
}
