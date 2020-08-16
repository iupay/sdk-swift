//
//  UIImageExtensions.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 11/08/2020.
//

import UIKit

extension UIImage {
    
    static func bundleImage(named: String) -> UIImage? {
        return UIImage(named: named, in: Bundle(for: BaseCardView.self), compatibleWith: nil)
    }
}
