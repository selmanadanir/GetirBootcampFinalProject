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
    func setLeftBarButton()
    func setRightBarButton()
}

final class ShoppingCardViewController: UIViewController {

    // MARK: - View
    private lazy var contentView: ComplateOrderButtonView = {
        let view = ComplateOrderButtonView()
        return view
    }()
    
    // MARK: - Internal Variable
    var presenter: ShoppingCardPresenterProtocol!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    // MARK: - Private Method
    private func setupView() {
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    @objc private func tappedLeftBarButton(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func tappeRigtBarButton(){
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - ShoppingCardViewControllerProtocol
extension ShoppingCardViewController: ShoppingCardViewControllerProtocol {
    func setTitle() {
        title = AppText.getText(.shoppingCardTitle)
    }
    
    func showDetailScreen() {
        print("ShoppingCardViewController")
    }
    
    func setLeftBarButton() {
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "multiply"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(tappedLeftBarButton))
        self.navigationController?.navigationBar.tintColor = AppColor.getColor(.white)
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    func setRightBarButton() {
        let rightBarButton = UIBarButtonItem(image: AppIcon.getIcon(.trash, AppColor.getColor(.white)),
                                             style: .plain,
                                             target: self,
                                             action: #selector(tappeRigtBarButton))
        self.navigationController?.navigationBar.tintColor = AppColor.getColor(.white)
        navigationItem.rightBarButtonItem = rightBarButton
    }
}

// MARK: - BasketAmountViewDelegate
extension ShoppingCardViewController: BasketAmountViewDelegate {
    func clickBasketAmountButton() {
        print("clickBasketAmountButton")
    }
}
