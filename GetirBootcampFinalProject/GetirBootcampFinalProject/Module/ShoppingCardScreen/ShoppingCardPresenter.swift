//
//  ShoppingCardPresenter.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 22.04.2024.
//

import Foundation
import FirebaseDatabase

protocol ShoppingCardPresenterProtocol: AnyObject {
    func viewDidLoad()
    func getProductsFirebase(index: Int) -> ProductItem?
    func getProductsCount() -> Int
    func getAmount() -> Double?
}

final class ShoppingCardPresenter {
    
    weak var view: ShoppingCardViewControllerProtocol!
    var interactor: ShoppingCardInteractorProtocol!
    var router: ShoppingCardRouterProtocol!
    
    private var products: [ProductModel]?
    private var firebaseProducts = [DataSnapshot]()
}

// MARK: - ShoppingCardPresenterProtocol
extension ShoppingCardPresenter: ShoppingCardPresenterProtocol {
    
    func viewDidLoad() {
        view.setTitle()
        view.showDetailScreen()
        view.setLeftBarButton()
        view.setRightBarButton()
        view.configureCollectionView()
        interactor.fetchProducts()
        interactor.fetchDataToFirebase()
    }
    
    func getProductsFirebase(index: Int) -> ProductItem? {
        let model = products?.first?.products
        let key = firebaseProducts[index].key
        
        let result = model?.filter({ item in
            item.id == key
        })
        
        return result?.first
    }
    
    func getProductsCount() -> Int {
        firebaseProducts.count
    }
    
    func getAmount() -> Double? {
        let model = products?.first?.products
        var amount: Double = 0
        
        firebaseProducts.forEach { dataSnapshot in
            guard let productCount = dataSnapshot.value as? Int else { return }
            let key = dataSnapshot.key
            
            let result = model?.filter({ item in
                item.id == key
            })
            guard let price = result?.first?.price else { return }
            amount += price * Double(productCount)
        }
        return amount
    }
}

// MARK: - ShoppingCardInteractorOutputProtocol
extension ShoppingCardPresenter: ShoppingCardInteractorOutputProtocol {
    func onSuccesProducts(products: [ProductModel]) {
        self.products = products
        view.reloadData()
    }
    
    func onFailureProducts(error: ErrorTypes) {
        view.showError()
    }
    
    func onSuccesFirebase(products: DataSnapshot) {
        firebaseProducts.append(products)
        view.reloadData()
    }
}
