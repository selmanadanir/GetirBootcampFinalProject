//
//  ProductsEntity.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 11.04.2024.
//

import Foundation

// MARK: - ProductElement
struct ProductElement: Codable {
    let id, name: String
    let productCount: Int
    let products: [ProductClass]
}

// MARK: - ProductClass
struct ProductClass: Codable {
    let id, name: String
    let attribute: String?
    let thumbnailURL, imageURL: String
    let price: Double
    let priceText: String
    let shortDescription: String?
}
