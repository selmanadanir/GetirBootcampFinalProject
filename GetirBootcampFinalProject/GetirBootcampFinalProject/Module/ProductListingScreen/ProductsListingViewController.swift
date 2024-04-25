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

final class ProductsListingViewController: BaseViewController {
    
    // MARK: - View
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView()
        return view
    }()
    
    private lazy var basketAmountView: BasketAmountView = {
        let view = BasketAmountView()
        view.delegate = self
        return view
    }()
    
    // MARK: - Internal Variable
    var presenter: ProductsListingPresenterProtocol!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - ProductsListingViewControllerProtocol
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

// MARK: - UICollectionViewDataSource
extension ProductsListingViewController: UICollectionViewDataSource {
    
    // MARK: - NumberOfSections
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
    
    // MARK: - CellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let sectionKind = BasketDirection(rawValue: indexPath.section) else { fatalError() }
        
        switch sectionKind {
        case .horizontal:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasketDirection.horizontal.name, for: indexPath) as? ProductListCollectionViewCell else { return UICollectionViewCell() }
            cell.suggestedProductModel = presenter.getSuggestedProduct(index: indexPath.row)
            cell.delegate = self
            return cell
            
        case .vertical:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasketDirection.vertical.name, for: indexPath) as? ProductListCollectionViewCell else { return UICollectionViewCell() }
            cell.productModel = presenter.getProduct(index: indexPath.row)
            cell.delegate = self
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension ProductsListingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let sectionKind = BasketDirection(rawValue: indexPath.section) else { fatalError() }
        guard let model = presenter.getProduct(index: indexPath.row) else { return }
        presenter.showDetailScreen(productItem: model)
    }
}

// MARK: - ProductListCollectionViewCellDelegate
extension ProductsListingViewController: ProductListCollectionViewCellDelegate {
    func didTappedUpgradeButton(productItem: ProductItem, productCount: Int) {
        presenter.upgradeChosenProducs(productItem: productItem)
        basketAmountView.amount = presenter.getBasketAmount()
        addNewEntryInFirebase(productId: productItem.id ?? "",
                              count: presenter.getChosenProductItemCount(productItem: productItem))
    }
    
    func didTappedDowngradeButton(productItem: ProductItem, productCount: Int) {
        presenter.downgradeChosenProducs(productItem: productItem)
        basketAmountView.amount = presenter.getBasketAmount()
        if presenter.getChosenProductItemCount(productItem: productItem) == 0 {
            removeData(id: productItem.id ?? "")
        } else {
            addNewEntryInFirebase(productId: productItem.id ?? "",
                                  count: presenter.getChosenProductItemCount(productItem: productItem))
        }
    }
}

// MARK: - BasketAmountViewDelegate
extension ProductsListingViewController: BasketAmountViewDelegate {
    func clickBasketAmountButton() {
        presenter.showShoppingCardScreen()
    }
}
