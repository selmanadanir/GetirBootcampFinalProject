//
//  AppSize.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 11.04.2024.
//

import UIKit

struct AppSize {
    enum Size: Int {
        case primary =  14
        case secondary = 12
    }
    
    static func getSize(_ size: Size) -> Int {
        return size.rawValue
    }
}
