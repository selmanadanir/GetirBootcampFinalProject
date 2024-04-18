//
//  ProductListCollectionViewCell.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 13.04.2024.
//

import UIKit

protocol ProductListCollectionViewCellFirstDelegate: AnyObject {
    func didTappedFirstButton()
}

protocol ProductListCollectionViewCellSecondDelegate: AnyObject {
    func didTappedSecondButton()
}

final class ProductListCollectionViewCell: UICollectionViewCell {
    
    // MARK: Views
    private lazy var customBasketView: CustomBasketView = {
        let view = CustomBasketView()
        view.layer.cornerRadius = 18
        return view
    }()
    
    private lazy var customStepperView: CustomStepperView = {
        let view = CustomStepperView()
        view.firstDelegate = self
        view.secondDelegate = self
        return view
    }()
    
    // MARK: Internal Variable
    var productModel: ProductItem? {
        didSet {
            customBasketView.productModel = productModel
        }
    }
    
    var suggestedProductModel: SuggestedProductItem? {
        didSet {
            customBasketView.suggestedProductModel = suggestedProductModel
        }
    }
    
    weak var firstDelegate: ProductListCollectionViewCellFirstDelegate?
    weak var secondDelegate: ProductListCollectionViewCellSecondDelegate?
    
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
        addSubview(customBasketView)
        addSubview(customStepperView)
        
        customBasketView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        customStepperView.snp.makeConstraints { make in
            make.top.equalTo(customBasketView.snp.top).offset(-5)
            make.trailing.equalTo(customBasketView.snp.trailing).offset(10)
        }
    }
}

// MARK: CustomStepperViewFirstDelegate
extension ProductListCollectionViewCell: CustomStepperViewFirstDelegate {
    func didTappedFirstButton() {
        firstDelegate?.didTappedFirstButton()
    }
}

// MARK: CustomStepperViewSecondDelegate
extension ProductListCollectionViewCell: CustomStepperViewSecondDelegate {
    func didTappedSecondButton() {
        secondDelegate?.didTappedSecondButton()
    }
}
