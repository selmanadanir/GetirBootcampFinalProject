//
//  ProductsListingInteractor.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 11.04.2024.
//

import Foundation

protocol ProductsListingInteractorProtocol {
    func fetchProducts()
    func fetchSuggestedProduct()
}

protocol ProductsListingOutputProtocol: AnyObject {
    func onSuccesProducts(products: [ProductModel])
    func onFailureProducts(error: ErrorTypes)
    func onSuccesSuggested(suggestedProducts: [SuggestedProductModel])
    func onFailureSuggested(error: ErrorTypes)
}

final class ProductsListingInteractor {
    var output: ProductsListingOutputProtocol?
}

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
}
