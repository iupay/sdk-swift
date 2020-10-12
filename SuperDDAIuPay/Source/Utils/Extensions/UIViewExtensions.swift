//
//  UIViewExtensions.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 17/08/2020.
//

import UIKit

extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.frame = self.bounds
        mask.path = path.cgPath
        layer.mask = mask
    }
}
