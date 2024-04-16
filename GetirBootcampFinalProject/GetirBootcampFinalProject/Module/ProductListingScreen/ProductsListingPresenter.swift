//
//  ProductsListingPresenter.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 11.04.2024.
//

import Foundation

protocol ProductsListingPresenterProtocol: AnyObject {
    func viewDidLoad()
    func getProduct(index: Int) -> ProductItem?
    func numberOfProductsItem() -> Int
    func getSuggestedProduct(index: Int) -> SuggestedProductItem?
    func numberOfSuggestedProductsItem() -> Int
}

final class ProductsListingPresenter {
    
    weak var view: ProductsListingViewControllerProtocol!
    var interactor: ProductsListingInteractorProtocol!
    var router: ProductsRouterProtocol!
    
    private var products: [ProductModel]?
    private var suggestedProducts: [SuggestedProductModel]?
}

extension ProductsListingPresenter: ProductsListingPresenterProtocol {
    
    func viewDidLoad() {
        interactor.fetchProducts()
        interactor.fetchSuggestedProduct()
    }
    
    func getProduct(index: Int) -> ProductItem? {
        products?.first?.products?[index]
    }
    
    func numberOfProductsItem() -> Int {
        products?.first?.products?.count ?? 0
    }
    
    func getSuggestedProduct(index: Int) -> SuggestedProductItem? {
        suggestedProducts?.first?.products?[index]
    }
    
    func numberOfSuggestedProductsItem() -> Int {
        suggestedProducts?.first?.products?.count ?? 0
    }
}

extension ProductsListingPresenter: ProductsListingOutputProtocol {
    
    func onSuccesProducts(products: [ProductModel]) {
        self.products = products
        view.reloadData()
    }
    
    func onFailureProducts(error: ErrorTypes) {
        view?.showError(error: error)
    }
    
    func onSuccesSuggested(suggestedProducts: [SuggestedProductModel]) {
        self.suggestedProducts = suggestedProducts
        view.reloadData()
    }
    
    func onFailureSuggested(error: ErrorTypes) {
        view.showError(error: error)
    }
}
