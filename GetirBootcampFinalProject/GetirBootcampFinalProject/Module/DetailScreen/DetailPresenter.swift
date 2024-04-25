//
//  DetailPresent.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 19.04.2024.
//

import UIKit

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func getProductItem() -> ProductItem?
    func upgradeChosenProducCount()
    func downgradeChosenProducCount()
    func getBasketAmount() -> Double
    func getChosenProductItemCount() -> Int
    func showShoppingCardScreen()
}

final class DetailPresenter {
    
    weak var view: DetailViewControllerProtocol!
    var interactor: DetailInteractorProtocol!
    var router: DetailRouterProtocol!
    
    var productItem: ProductItem?
    private var productCount: Int = 0
}

// MARK: - DetailPresentProtocol

extension DetailPresenter: DetailPresenterProtocol {
    func viewDidLoad() {
        view.showDetailScreen()
        view.setTitle()
        view.popViewController()
    }
    
    func getProductItem() -> ProductItem? {
        productItem
    }
    
    func upgradeChosenProducCount() {
        if productCount < 5 {
            productCount += 1
        }
    }

    
    func downgradeChosenProducCount() {
        if productCount > 1 {
            productCount -= 1
        } else if productCount == 1 {
            productCount = 0
            router.navigateToShoppingCardScreen(.productsList)
        }
    }
    
    func getBasketAmount() -> Double {
        return (productItem?.price ?? 0) * Double(productCount)
    }
    
    func getChosenProductItemCount() -> Int {
        productCount
    }
    
    func showShoppingCardScreen() {
        router.navigateToShoppingCardScreen(.detailView)
    }
}

// MARK: - DetailInteractorOutputProtocol
extension DetailPresenter: DetailInteractorOutputProtocol {
    
}
