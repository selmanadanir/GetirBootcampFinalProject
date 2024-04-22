//
//  DetailRouter.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 19.04.2024.
//

import Foundation

enum DetailRouterRoutes {
    case detailView
}

protocol DetailRouterProtocol: AnyObject {
    func navigateToShoppingCardScreen(_ route: DetailRouterRoutes)
}

final class DetailRouter {
    
    weak var viewController: DetailViewController?
    
    static func createModule(productItem: ProductItem) -> DetailViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.productItem = productItem
        
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
}

// MARK: - DetailRouterProtocol
extension DetailRouter: DetailRouterProtocol {
    func navigateToShoppingCardScreen(_ route: DetailRouterRoutes) {
        switch route {
        case .detailView:
            let shoppingCardViewController = ShoppingCardRouter.createModule()
            viewController?.navigationController?.pushViewController(shoppingCardViewController, animated: true)
        }
    }
}
