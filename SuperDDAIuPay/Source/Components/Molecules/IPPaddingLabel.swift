//
//  IPPaddingLabel.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 06/10/2020.
//

import UIKit

// MARK: - IPPaddingLabel
public final class IPPaddingLabel: UILabel {
    
    // MARK: Custom initializer
    init(text: String? = nil, fontSize: CGFloat, weight: UIFont.Weight, textColor: UIColor) {
        super.init(frame: .zero)
        self.textColor = textColor
        self.font = UIFont.customFont(ofSize: fontSize, weight: weight)
        self.text = text
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: UIEdgeInsets(top: 0, left: .bigMediumMargin, bottom: 0, right: .bigMediumMargin)))
    }
}
