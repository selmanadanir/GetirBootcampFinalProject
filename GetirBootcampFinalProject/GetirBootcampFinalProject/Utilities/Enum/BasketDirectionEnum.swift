//
//  BasketDirectionEnum.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 15.04.2024.
//

import Foundation

enum BasketDirection: Int, CaseIterable {
    case horizontal
    case vertical
    
    var name: String {
        switch self {
        case .horizontal:
            return "horizontal"
        case .vertical:
            return "vertical"
        }
    }
}
