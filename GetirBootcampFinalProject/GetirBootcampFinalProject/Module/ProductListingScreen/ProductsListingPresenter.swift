//
//  ProductsListingPresenter.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 11.04.2024.
//

import Foundation
import FirebaseDatabase

protocol ProductsListingPresenterProtocol: AnyObject {
    func viewDidLoad()
    func getProduct(index: Int) -> ProductItem?
    func numberOfProductsItem() -> Int
    func getSuggestedProduct(index: Int) -> SuggestedProductItem?
    func numberOfSuggestedProductsItem() -> Int
    func calculateHorizontalBasketAmount(index: Int) -> Double
    func calculateVerticalBasketAmount(index: Int) -> Double
    func upgradeChosenProducs(productItem: ProductItem)
    func downgradeChosenProducs(productItem: ProductItem)
    func getChosenProductItem() -> [ProductItem: Int]
    func getChosenProductItemCount(productItem: ProductItem) -> Int
    func getBasketAmount() -> Double
    func showDetailScreen(productItem: ProductItem)
    func showShoppingCardScreen()
}

final class ProductsListingPresenter {
    
    weak var view: ProductsListingViewControllerProtocol!
    var interactor: ProductsListingInteractorProtocol!
    var router: ProductsRouterProtocol!
    
    private var products: [ProductModel]?
    private var suggestedProducts: [SuggestedProductModel]?
    private var chosenProducts: [ProductItem: Int] = [:]
    private var basketAmount: Double = 0
    private var data: DataSnapshot?
    let database = Database.database().reference()
}

extension ProductsListingPresenter: ProductsListingPresenterProtocol {
    
    func viewDidLoad() {
        view.setTitle(AppText.getText(.productsScreenTitle))
        view.setRightBarButton()
        view.configureCollectionView()
        interactor.fetchProducts()
        interactor.fetchSuggestedProduct()
        interactor.fetchDataToFirebase()
    }
    
    func getSuggestedProduct(index: Int) -> SuggestedProductItem? {
        suggestedProducts?.first?.products?[index]
    }
    
    func getProduct(index: Int) -> ProductItem? {
        products?.first?.products?[index]
    }
    
    func numberOfSuggestedProductsItem() -> Int {
        suggestedProducts?.first?.products?.count ?? 0
    }
    
    func numberOfProductsItem() -> Int {
        products?.first?.products?.count ?? 0
    }
    
    func calculateHorizontalBasketAmount(index: Int) -> Double {
        suggestedProducts?.first?.products?[index].price ?? 0
    }
    
    func calculateVerticalBasketAmount(index: Int) -> Double {
        products?.first?.products?[index].price ?? 0
    }
    
    func upgradeChosenProducs(productItem: ProductItem) {
        
        if chosenProducts.keys.contains(productItem) {
            if chosenProducts[productItem]! < 5 {
                chosenProducts[productItem]! += 1
            }
        } else {
            chosenProducts[productItem] = 1
        }
    }
    
    func downgradeChosenProducs(productItem: ProductItem) {
        
        if chosenProducts.keys.contains(productItem) {
            if chosenProducts[productItem]! >= 1 {
                chosenProducts[productItem]! -= 1
            }
        }
    }
    
    func getChosenProductItem() -> [ProductItem: Int] {
        chosenProducts
    }
    
    func getChosenProductItemCount(productItem: ProductItem) -> Int {
        chosenProducts[productItem] ?? 0
    }
    
    func getBasketAmount() -> Double {
        basketAmount = 0
        for (item, count) in chosenProducts {
            basketAmount += (item.price ?? 0) * Double(count)
        }
        return basketAmount
    }
    
    func showDetailScreen(productItem: ProductItem) {
        router.navigateToDetailsScreen(productItem: productItem, .detailView)
    }
    
    func showShoppingCardScreen() {
        router.navigateToShoppingScreen()
    }
}

// MARK: - ProductsListingOutputProtocol
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
    
    func onSuccesFirebase(data: DataSnapshot) {
        self.data = data
    }
}
