//
//  extensions.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 13/08/2020.
//

import Foundation


extension UIFont {
 
    private class GetBundle {}

    static func loadFontWith(name: String) {
        let frameworkBundle = Bundle(for: GetBundle.self)
        guard
            let pathForResourceString = frameworkBundle.path(forResource: name, ofType: "ttf"),
            let fontData = NSData(contentsOfFile: pathForResourceString),
            let dataProvider = CGDataProvider(data: fontData),
            let fontRef = CGFont(dataProvider)
        else { return }
        var errorRef: Unmanaged<CFError>? = nil

        if (CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) == false) {
            NSLog("Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
        }
    }

    public static let loadIuPayFonts: () = {
        loadFontWith(name: "NunitoSans-Bold")
        loadFontWith(name: "NunitoSans-Light")
        loadFontWith(name: "NunitoSans-Regular")
        loadFontWith(name: "NunitoSans-SemiBold")
    }()
    
    static func customFont(ofSize size: CGFloat, weight: Weight) -> UIFont? {
        switch weight {
        case .light: return UIFont(name: "NunitoSans-Light", size: size)
        case .semibold: return UIFont(name: "NunitoSans-SemiBold", size: size)
        case .bold: return UIFont(name: "NunitoSans-Bold", size: size)
        default: return UIFont(name: "NunitoSans-Regular", size: size)
        }
        
    }
}

extension CGFloat {
    /// Equals to: 8.0
    static let smallestMargin: CGFloat = 8.0
    /// Equals to: 12.0
    static let smallMargin: CGFloat = 12.0
    /// Equals to: 16.0
    static let mediumMargin: CGFloat = 16.0
    /// Equals to: 24.0
    static let bigMediumMargin: CGFloat = 24.0
    
    static let preLargeMargin: CGFloat = 28.0
    /// Equals to: 32.0
    static let largeMargin: CGFloat = 32.0
    /// Equals to: 44.0
    static let defaultArea: CGFloat = 44.0
}

extension UIColor {
    static let yellowKit: UIColor = .from(hex: "#ebbf10")
    static let redKit: UIColor = .from(hex: "#e30613")
    static let grayKit: UIColor = .from(hex: "#727272")
    static let lightGrayKit: UIColor = .from(hex: "#7a7a7b")
}
