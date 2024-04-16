//
//  ProductsRouter.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 11.04.2024.
//

import Foundation

protocol ProductsRouterProtocol: AnyObject {
    func navigateToDetailsScreen()
}

final class ProductsListingRouter {
    weak var viewController: ProductsListingViewController?
    
    static func createModule() -> ProductsListingViewController {
        let view = ProductsListingViewController()
        let presenter = ProductsListingPresenter()
        let interactor = ProductsListingInteractor()
        let router = ProductsListingRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
}

extension ProductsListingRouter: ProductsRouterProtocol {
    func navigateToDetailsScreen() {
        /// TODO  navigate detail
    }
}
