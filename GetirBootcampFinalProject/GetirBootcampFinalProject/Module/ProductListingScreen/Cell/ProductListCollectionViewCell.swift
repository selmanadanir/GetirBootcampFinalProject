//
//  ProductListCollectionViewCell.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 13.04.2024.
//

import UIKit

final class ProductListCollectionViewCell: UICollectionViewCell {
    
    // MARK: Views
    private lazy var customBasketView: CustomBasketView = {
        let view = CustomBasketView()
        view.layer.cornerRadius = 18
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
        customBasketView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
