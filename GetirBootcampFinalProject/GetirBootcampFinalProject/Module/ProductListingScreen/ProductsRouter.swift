//
//  ProductsRouter.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 11.04.2024.
//

import UIKit

enum ProductsListingRoutes {
    case detailView
}

protocol ProductsRouterProtocol: AnyObject {
    func navigateToDetailsScreen(productItem: ProductItem, _ route: ProductsListingRoutes)
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

// MARK: - ProductsRouterProtocol
extension ProductsListingRouter: ProductsRouterProtocol {
    func navigateToDetailsScreen(productItem: ProductItem, _ route: ProductsListingRoutes) {
        switch route {
        case .detailView:
            let detailViewController = DetailRouter.createModule(productItem: productItem)
            viewController?.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
