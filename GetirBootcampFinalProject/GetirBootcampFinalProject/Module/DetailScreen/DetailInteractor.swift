//
//  DetailInteractor.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 19.04.2024.
//

import Foundation

protocol DetailInteractorProtocol {
    
}

protocol DetailInteractorOutputProtocol: AnyObject {
    
}

final class DetailInteractor {
    
    var output: DetailInteractorOutputProtocol?
}

// MARK: - DetailInteractorProtocol
extension DetailInteractor: DetailInteractorProtocol {
    
}
