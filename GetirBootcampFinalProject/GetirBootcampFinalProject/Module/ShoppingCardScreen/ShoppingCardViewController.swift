//
//  ShoppingCardViewController.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 22.04.2024.
//

import UIKit

protocol ShoppingCardViewControllerProtocol: AnyObject {
    func setTitle()
    func showDetailScreen()
}

final class ShoppingCardViewController: UIViewController {
    
    // MARK: - Internal Variable
    var presenter: ShoppingCardPresenterProtocol!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        view.backgroundColor = .red
    }
}

extension ShoppingCardViewController: ShoppingCardViewControllerProtocol {
    func setTitle() {
        title = AppText.getText(.shoppingCardTitle)
    }
    
    func showDetailScreen() {
        print("ShoppingCardViewController")
    }
}
