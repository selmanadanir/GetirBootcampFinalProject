//
//  AnalyticsEvent.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 25.04.2024.
//

import Foundation

struct AnalyticsEvent {
    
    enum EventName: String {
        case clickProductInProductListScreen = "CLICK_PRODUCT_IN_PRODUCTION_LIST_SCREEN"
        case clickUpgradeButton = "CLICK_UPGRADE_BUTTON"
        case clickDowngradeButton = "CLICK_DOWNGRADE_BUTTON"
        case clickBasketAmount = "CLICK_BASKET_AMOUNT"
    }
    static func getText(_ text: EventName) -> String {
        return text.rawValue
    }
}
