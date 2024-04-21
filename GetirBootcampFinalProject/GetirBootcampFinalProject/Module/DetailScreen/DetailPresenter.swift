//
//  DetailPresent.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 19.04.2024.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func getProductItem() -> ProductItem?
    func upgradeChosenProducs(productItem: ProductItem)
    func downgradeChosenProducs(productItem: ProductItem)
    func getBasketAmount() -> Double
}

final class DetailPresenter {
    
    weak var view: DetailViewControllerProtocol!
    var interactor: DetailInteractorProtocol!
    var router: DetailRouterProtocol!
    
    var productItem: ProductItem?
    private var basketAmount: Double = 0
    private var chosenProducts: [ProductItem: Int] = [:]
}

// MARK: - DetailPresentProtocol

extension DetailPresenter: DetailPresenterProtocol {
    func viewDidLoad() {
        view.showDetailScreen()
    }
    
    func getProductItem() -> ProductItem? {
        productItem
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
            if chosenProducts[productItem]! > 1 {
                chosenProducts[productItem]! -= 1
            }
        }
    }
    
    func getBasketAmount() -> Double {
        basketAmount = 0
        for (item, count) in chosenProducts {
            basketAmount += item.price * Double(count)
        }
        return basketAmount
    }
}

// MARK: - DetailInteractorOutputProtocol
extension DetailPresenter: DetailInteractorOutputProtocol {
    
}
