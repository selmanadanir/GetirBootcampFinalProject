//
//  ShoppingCardInteractor.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 22.04.2024.
//

import Foundation

protocol ShoppingCardInteractorProtocol {
    
}

protocol ShoppingCardInteractorOutputProtocol: AnyObject {
    
}

final class ShoppingCardInteractor {
    
    var output: ShoppingCardInteractorOutputProtocol?
}

// MARK: - DetailInteractorProtocol
extension ShoppingCardInteractor: ShoppingCardInteractorProtocol {
    
}
