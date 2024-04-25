//
//  ShoppingCardRouter.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 22.04.2024.
//

import UIKit

protocol ShoppingCardRouterProtocol: AnyObject {
    
}

final class ShoppingCardRouter {
    
    weak var viewController: ShoppingCardViewController?
    
    static func createModule( ) -> ShoppingCardViewController {
        let view = ShoppingCardViewController()
        let presenter = ShoppingCardPresenter()
        let interactor = ShoppingCardInteractor()
        let router = ShoppingCardRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
}

// MARK: - DetailRouterProtocol
extension ShoppingCardRouter: ShoppingCardRouterProtocol {
    
}
