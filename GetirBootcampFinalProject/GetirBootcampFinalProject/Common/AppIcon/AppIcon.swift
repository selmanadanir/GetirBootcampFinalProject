//
//  AppIcon.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 17.04.2024.
//

import UIKit

struct AppIcon {
    enum Name: String {
        case plus = "plus"
        case trash = "trash"
        case basket = "basket"
        case minus = "minus"
    }
    
    static func getIcon(_ name: Name?,
                        _ color: UIColor? = nil,
                        _ renderingMode: UIImage.RenderingMode = .alwaysOriginal) -> UIImage? {
        guard let name = name else {
            return nil
        }
        var image = UIImage(named: name.rawValue)?.withRenderingMode(renderingMode)
        if let color = color {
            image = image?.withTintColor(color)
        }
        
        return image
    }
    
    static func getIcon(_ name: String?,
                        _ color: UIColor? = nil,
                        _ renderingMode: UIImage.RenderingMode = .alwaysOriginal) -> UIImage? {
        guard let name else { return nil }

        var image = UIImage(named: name)?.withRenderingMode(renderingMode)
        if let color = color {
            image = image?.withTintColor(color)
        }
        
        return image
    }
}
