//
//  ProductListCollectionViewCell.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 13.04.2024.
//

import UIKit

protocol ProductListCollectionViewCellDelegate: AnyObject {
    func didTappedUpgradeButton(productItem: ProductItem, productCount: Int)
    func didTappedDowngradeButton(productItem: ProductItem, productCount: Int)
}

final class ProductListCollectionViewCell: UICollectionViewCell {
    
    // MARK: Views
    private lazy var basketView: BasketView = {
        let view = BasketView()
        view.layer.cornerRadius = 18
        return view
    }()
    
    private lazy var stepperView: StepperViewForProductListing = {
        let view = StepperViewForProductListing()
        view.delegate = self
        return view
    }()
    
    // MARK: Internal Variable
    var productModel: ProductItem? {
        didSet {
            basketView.productModel = productModel
            stepperView.productItem = productModel
        }
    }
    
    var suggestedProductModel: SuggestedProductItem? {
        didSet {
            basketView.suggestedProductModel = suggestedProductModel
            stepperView.suggestProductItem = suggestedProductModel
        }
    }
    
    weak var delegate: ProductListCollectionViewCellDelegate?
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    private func setupView() {
        addSubview(basketView)
        addSubview(stepperView)
        
        basketView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stepperView.snp.makeConstraints { make in
            make.top.equalTo(basketView.snp.top).offset(-5)
            make.trailing.equalTo(basketView.snp.trailing).offset(10)
        }
    }
}

// MARK: StepperViewFirstDelegate
extension ProductListCollectionViewCell: StepperViewForProductListingProtocol {
    func didTappedUpgradeButton(productItem: ProductItem, productCount: Int) {
        delegate?.didTappedUpgradeButton(productItem: productItem, productCount: productCount)
    }
    
    func didTappedDowngradeButton(productItem: ProductItem, productCount: Int) {
        delegate?.didTappedDowngradeButton(productItem: productItem, productCount: productCount)
    }
}
