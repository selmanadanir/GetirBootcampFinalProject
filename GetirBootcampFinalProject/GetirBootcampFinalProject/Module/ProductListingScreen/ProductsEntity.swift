//
//  ProductsEntity.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 11.04.2024.
//

import Foundation

// MARK: - ProductElement
struct ProductModel: Codable {
    let id: String
    let name: String?
    let productCount: Int?
    let products: [ProductItem]?
    let email, password: String?
}

// MARK: - ProductClass
struct ProductItem: Codable, Hashable {
    let id, name: String
    let attribute: String?
    let thumbnailURL, imageURL: String
    let price: Double
    let priceText: String
    let shortDescription: String?
}

// MARK: - SuggestedProduct
struct SuggestedProductModel: Codable {
    let products: [SuggestedProductItem]?
    let id, name: String
}

// MARK: - Product
struct SuggestedProductItem: Codable, Hashable {
    let id: String
    let imageURL: String?
    let price: Double
    let name, priceText: String
    let shortDescription, category: String?
    let unitPrice: Double?
    let squareThumbnailURL: String?
    let status: Int?
}
