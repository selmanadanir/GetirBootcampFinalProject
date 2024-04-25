//
//  ShoppingCardInteractor.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 22.04.2024.
//

import Foundation
import FirebaseDatabase

protocol ShoppingCardInteractorProtocol {
    func fetchProducts()
    func fetchDataToFirebase()
}

protocol ShoppingCardInteractorOutputProtocol: AnyObject {
    func onSuccesProducts(products: [ProductModel])
    func onFailureProducts(error: ErrorTypes)
    func onSuccesFirebase(products: DataSnapshot)
}

final class ShoppingCardInteractor {
    
    var output: ShoppingCardInteractorOutputProtocol?
    let database = Database.database().reference()
}

// MARK: - DetailInteractorProtocol
extension ShoppingCardInteractor: ShoppingCardInteractorProtocol {
    
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
    
    func fetchDataToFirebase() {
        database.child("products").observeSingleEvent(of: .value) { snapshot in
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? DataSnapshot {
                self.output?.onSuccesFirebase(products: rest)
            }
        }
    }
}
