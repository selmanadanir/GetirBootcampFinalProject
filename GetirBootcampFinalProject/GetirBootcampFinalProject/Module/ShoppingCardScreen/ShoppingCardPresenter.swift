//
//  ShoppingCardPresenter.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 22.04.2024.
//

import Foundation

protocol ShoppingCardPresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class ShoppingCardPresenter {
    
    weak var view: ShoppingCardViewControllerProtocol!
    var interactor: ShoppingCardInteractorProtocol!
    var router: ShoppingCardRouterProtocol!
}

// MARK: - ShoppingCardPresenterProtocol
extension ShoppingCardPresenter: ShoppingCardPresenterProtocol {
    func viewDidLoad() {
        view.setTitle()
        view.showDetailScreen()
    }
}

// MARK: - ShoppingCardInteractorOutputProtocol
extension ShoppingCardPresenter: ShoppingCardInteractorOutputProtocol {
    
}
