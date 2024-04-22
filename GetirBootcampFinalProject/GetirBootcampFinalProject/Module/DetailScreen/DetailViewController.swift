//
//  DetailViewController.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 19.04.2024.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func setTitle()
    func showDetailScreen()
    func showAlert()
    func setRightBarButton()
    func popViewController()
}

final class DetailViewController: UIViewController {

    // MARK: - View
    private lazy var basketAmountView: BasketAmountView = {
        let view = BasketAmountView()
        view.delegate = self
        return view
    }()
    
    private lazy var basketView: BasketView = {
        let view = BasketView()
        view.shadowRadius = 3
        view.shadowColor = AppColor.getColor(.head)
        view.shadowOffset = .zero
        view.shadowOpacity = 0.2
        view.updateViewForProductDetailScreen()
        return view
    }()
    
    private lazy var bottomBasketButtonView: BottomBasketButtonView = {
        let view = BottomBasketButtonView()
        view.delegate = self
        return view
    }()
    
    // MARK: - Internal Method
    var presenter: DetailPresenterProtocol!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.viewDidLoad()
        setupView()
    }
    
    // MARK: - Private Method
    private func setupView() {
        view.addSubview(basketView)
        view.addSubview(bottomBasketButtonView)
        
        basketView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }

        bottomBasketButtonView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    @objc private func popViewConroller(){
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - DetailViewControllerProtocol
extension DetailViewController: DetailViewControllerProtocol {
    
    func setTitle() {
        title = AppText.getText(.detailScreenTitle)
    }
    
    func showDetailScreen() {
        basketView.productModel = presenter.getProductItem()
        bottomBasketButtonView.productModel = presenter.getProductItem()
    }
    
    func showAlert() {
        /// TODO
    }
    
    func setRightBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: basketAmountView)
    }
    
    func popViewController() {
        let cancelButton = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(popViewConroller))
        self.navigationController?.navigationBar.tintColor = AppColor.getColor(.white)
        navigationItem.leftBarButtonItem = cancelButton
    }
}

extension DetailViewController: BottomBasketButtonViewDelegate {
    
    func addToBasketButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: basketAmountView)
        guard let productItem = presenter.getProductItem() else { return }
        presenter.upgradeChosenProducs(productItem: productItem)
        basketAmountView.amount = presenter.getBasketAmount()
    }
    
    func didTappedUpgradeButton(productItem: ProductItem, productCount: Int) {
        presenter.upgradeChosenProducs(productItem: productItem)
        basketAmountView.amount = presenter.getBasketAmount()
    }
    
    func didTappedDowngradeButton(productItem: ProductItem, productCount: Int) {
        presenter.downgradeChosenProducs(productItem: productItem)
        basketAmountView.amount = presenter.getBasketAmount()
    }
}

extension DetailViewController: BasketAmountViewDelegate {
    func clickBasketAmountButton() {
        presenter.showShoppingCardScreen()
    }
}
