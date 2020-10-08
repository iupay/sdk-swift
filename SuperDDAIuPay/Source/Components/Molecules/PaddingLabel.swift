//
//  PaddingLabel.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 06/10/2020.
//

import UIKit

public final class PaddingLabel: UILabel {
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: UIEdgeInsets(top: 0, left: .bigMediumMargin, bottom: 0, right: .bigMediumMargin)))
    }
}
