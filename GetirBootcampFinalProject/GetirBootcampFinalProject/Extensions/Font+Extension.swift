//
//  Font+Extension.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 12.04.2024.
//

import UIKit

extension UIFont {
    
    enum CustomWeight: String {
        case bold = "Bold"
        case boldItalic = "BoldItalic"
        case extraBold = "ExtraBold"
        case extraBoldItalic = "ExtraBoldItalic"
        case italic = "Italic"
        case light = "Light"
        case lightItalic = "LightItalic"
        case medium = "Medium"
        case mediumItalic = "MediumItalic"
        case regular = "Regular"
        case semiBold = "SemiBold"
        case semiBoldItalic = "SemiBoldItalic"
    }
    
    enum Font: String {
        case openSans = "OpenSans"
    }
    
    static func font(_ name: Font, _ weight: CustomWeight, size: CGFloat) -> UIFont {
        UIFont(name: "\(name.rawValue)-\(weight.rawValue)", size: size)!
    }
}
