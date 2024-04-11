//
//  AppFont.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 11.04.2024.
//

import UIKit

/// Project color's rawvalue in assets
struct AppColor {
    enum Name: String {
        case body = "bodyColorSet"
        case head = "headColorSet"
        case white = "whiteColorSet"
        case primary = "primaryColorSet"
        case background = "backgroundColorSet"
    }
    
    static func getColor(_ name: Name) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
}
