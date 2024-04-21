//
//  DetailRouter.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 19.04.2024.
//

import Foundation

protocol DetailRouterProtocol: AnyObject {
    
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
    
}
