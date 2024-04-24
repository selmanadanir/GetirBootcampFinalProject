//
//  ProductsListingInteractor.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 11.04.2024.
//

import Foundation
import FirebaseDatabase

protocol ProductsListingInteractorProtocol {
    func fetchProducts()
    func fetchSuggestedProduct()
    func fetchDataToFirebase()
}

protocol ProductsListingOutputProtocol: AnyObject {
    func onSuccesProducts(products: [ProductModel])
    func onFailureProducts(error: ErrorTypes)
    func onSuccesSuggested(suggestedProducts: [SuggestedProductModel])
    func onFailureSuggested(error: ErrorTypes)
    func onSuccesFirebase(data: DataSnapshot)
}

final class ProductsListingInteractor {
    var output: ProductsListingOutputProtocol?
    let database = Database.database().reference()
}

// MARK: - ProductsListingInteractorProtocol
extension ProductsListingInteractor: ProductsListingInteractorProtocol {
    
    func fetchProducts() {
        NetworkManager.shared.request(type: [ProductModel].self, api: .products) { response in
            switch response {
            case .success(let success):
                self.output?.onSuccesProducts(products: success)
            case .failure(let error):
                self.output?.onFailureProducts(error: error)
            }
        }
    }
    
    func fetchSuggestedProduct() {
        NetworkManager.shared.request(type: [SuggestedProductModel].self, api: .suggestedProducts) { response in
            switch response {
            case .success(let success):
                self.output?.onSuccesSuggested(suggestedProducts: success)
            case .failure(let error):
                self.output?.onFailureSuggested(error: error)
            }
        }
    }
    
    func fetchDataToFirebase() {
        database.child("products").observeSingleEvent(of: .value) { snapshot in
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? DataSnapshot {
                self.output?.onSuccesFirebase(data: rest)
            }
        }
    }
}
