//
//  ViewController.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 10.04.2024.
//

import UIKit
import SnapKit

protocol ProductsListingViewControllerProtocol: AnyObject {
    func reloadData()
    func setTitle(_ title: String)
    func setRightBarButton()
    func showError(error: ErrorTypes)
    func configureCollectionView()
}

final class ProductsListingViewController: UIViewController {
    
    // MARK: View
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView()
        return view
    }()
    
    private lazy var basketAmountView: BasketAmountView = {
        let view = BasketAmountView()
        view.delegate = self
        return view
    }()
    
    // MARK: Internal Variable
    var presenter: ProductsListingPresenterProtocol!
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension ProductsListingViewController: ProductsListingViewControllerProtocol {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setRightBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: basketAmountView)
    }
    
    func showError(error: ErrorTypes) {
        print(error)
    }
    
    func configureCollectionView() {
        /// if the user's phone is an iPhone Se, it updates the constraint
        let isWideView: CGFloat = UIScreen.main.bounds.width
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: LayoutManger.generateProductsListingCollectionLayout(isWide: isWideView > 375))
        view.addSubview(collectionView)
        collectionView.register(ProductListCollectionViewCell.self, forCellWithReuseIdentifier: BasketDirection.horizontal.name)
        collectionView.register(ProductListCollectionViewCell.self, forCellWithReuseIdentifier: BasketDirection.vertical.name)
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = AppColor.getColor(.white)
    }
}

extension ProductsListingViewController: UICollectionViewDataSource {
    
    // MARK: NumberOfSections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return BasketDirection.allCases.count
    }
    
    // MARK: NumberOfItems
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionKind = BasketDirection(rawValue: section) else { fatalError() }
        switch sectionKind {
        case .horizontal:
            return presenter.numberOfSuggestedProductsItem()
        case .vertical:
            return presenter.numberOfProductsItem()
        }
    }
    
    // MARK: CellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let sectionKind = BasketDirection(rawValue: indexPath.section) else { fatalError() }
        
        switch sectionKind {
        case .horizontal:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasketDirection.horizontal.name, for: indexPath) as! ProductListCollectionViewCell
            cell.suggestedProductModel = presenter.getSuggestedProduct(index: indexPath.row)
            cell.delegate = self
            return cell
            
        case .vertical:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasketDirection.vertical.name, for: indexPath) as! ProductListCollectionViewCell
            cell.productModel = presenter.getProduct(index: indexPath.row)
            cell.delegate = self
            return cell
        }
    }
}

extension ProductsListingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let sectionKind = BasketDirection(rawValue: indexPath.section) else { fatalError() }
        print(sectionKind)
        switch sectionKind {
        case .horizontal:
//            basketAmount += presenter.calculateHorizontalBasketAmount(index: indexPath.row)
//            basketAmountView.amount = basketAmount
            print(presenter.calculateHorizontalBasketAmount(index: indexPath.row))
        case .vertical:
//            basketAmount += presenter.calculateVerticalBasketAmount(index: indexPath.row)
//            basketAmountView.amount = basketAmount
            print(presenter.calculateVerticalBasketAmount(index: indexPath.row))
        }
    }
}

extension ProductsListingViewController: ProductListCollectionViewCellDelegate {
    func didTappedUpgradeButton(productItem: ProductItem, productCount: Int) {
        presenter.upgradeChosenProducs(productItem: productItem)
        basketAmountView.amount = presenter.getBasketAmount()
        
        /// TODO show alert, maximum 5 products can be selected
        /// TODO  write new count of product to firebase
    }
    
    func didTappedDowngradeButton(productItem: ProductItem, productCount: Int) {
        presenter.downgradeChosenProducs(productItem: productItem)
        basketAmountView.amount = presenter.getBasketAmount()
        
        /// TODO  write new count of product to firebase
    }
}

extension ProductsListingViewController: BasketAmountViewDelegate {
    func clickBasketAmountButton() {
        print("clickBasketAmountButton")
    }
}
