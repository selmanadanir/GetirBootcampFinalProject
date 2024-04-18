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
    func showError(error: ErrorTypes)
}

final class ProductsListingViewController: UIViewController {
    
    var presenter: ProductsListingPresenterProtocol!
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configureCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: Helpers
    private func configureCollectionView() {
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

extension ProductsListingViewController: ProductsListingViewControllerProtocol {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showError(error: ErrorTypes) {
        print(error)
    }
}

extension ProductsListingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /// TODO route to detail screen
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
            cell.firstDelegate = self
            cell.secondDelegate = self
            return cell
            
        case .vertical:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasketDirection.vertical.name, for: indexPath) as! ProductListCollectionViewCell
            cell.productModel = presenter.getProduct(index: indexPath.row)
            cell.firstDelegate = self
            cell.secondDelegate = self
            return cell
        }
    }
}

extension ProductsListingViewController: ProductListCollectionViewCellFirstDelegate {
    func didTappedFirstButton() {
        /// TODO maximum 5 products can be selected
        /// TODO firebase write new count of product
        /// TODO update cart amount
    }
}

extension ProductsListingViewController: ProductListCollectionViewCellSecondDelegate {
    func didTappedSecondButton() {
        /// TODO firebase write new count of product
        /// TODO update cart amount
    }
}
