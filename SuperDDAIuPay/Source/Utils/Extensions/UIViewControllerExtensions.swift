//
//  UIViewControllerExtensions.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 12/10/2020.
//

import UIKit

extension UIViewController {
    
    func label(caption: String,
               text: String,
               sizeCaption: CGFloat,
               sizeText: CGFloat,
               textColor: UIColor? = .grayKit,
               breakLine: Bool = true,
               underlined: Bool = false) -> IPPaddingLabel {
        
       let captionAttribute = [
            NSAttributedString.Key.font: UIFont.customFont(ofSize: sizeCaption, weight: .regular),
            NSAttributedString.Key.foregroundColor: textColor
        ]
        
        let caption = NSAttributedString(string: caption + (breakLine ? "\n" : ""), attributes: captionAttribute as [NSAttributedString.Key : Any])
        
        var focusedAttribute = [
            NSAttributedString.Key.font: UIFont.customFont(ofSize: sizeText, weight: .bold),
            NSAttributedString.Key.foregroundColor: textColor
        ]
        
        if underlined {
            focusedAttribute[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue as NSObject
        }
        
        let totalAmount = NSAttributedString(string: text, attributes: focusedAttribute as [NSAttributedString.Key : Any])
        
        let combination = NSMutableAttributedString()
        combination.append(caption)
        combination.append(totalAmount)
        
        let label = IPPaddingLabel(frame: .zero)
        label.attributedText = combination
        label.numberOfLines = 0
        
        return label
    }
}
