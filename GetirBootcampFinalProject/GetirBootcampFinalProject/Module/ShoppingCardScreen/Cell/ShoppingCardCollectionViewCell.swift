//
//  ShoppingCardCollectionViewCell.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 23.04.2024.
//

import UIKit

final class ShoppingCardCollectionViewCell: UICollectionViewCell {
    
    // MARK: - View
    private lazy var basketView: BasketView = {
        let view = BasketView(isForDetailScreen: false)
        return view
    }()
    
    private lazy var stepperView: StepperView = {
        let view = StepperView(isForBottomBasketButton: false)
        return view
    }()
    
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
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(basketView)
        addSubview(stepperView)
        
        basketView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        stepperView.snp.makeConstraints { make in
            make.leading.equalTo(basketView.snp.trailing)
            make.top.trailing.bottom.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(90)
        }
    }
}
