//
//  AppText.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 18.04.2024.
//

import Foundation

struct AppText {
    enum Text: String {
        case productsScreenTitle = "Ürünler"
        case addToBasket = "Sepete Ekle"
        case detailScreenTitle = "Ürün Detayı"
        case shoppingCardTitle = "Sepetim"
    }
    
    static func getText(_ text: Text) -> String {
        return text.rawValue
    }
}
