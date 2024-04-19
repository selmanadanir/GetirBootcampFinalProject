//
//  BasketView.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 12.04.2024.
//

import UIKit
import Kingfisher
import SkeletonView

final class BasketView: UIView {
    
    // MARK: View
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 2
        view.layer.borderColor = AppColor.getColor(.background)?.cgColor
        view.backgroundColor = AppColor.getColor(.white)
        view.isSkeletonable = true
        return view
    }()
    
    private lazy var firstLabel: UILabel = {
        let view = UILabel()
        view.font = .font(.openSans, .bold, size: AppSize.getSize(.primary))
        view.textColor = AppColor.getColor(.primary)
        view.textAlignment = .natural
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var secondLabel: UILabel = {
        let view = UILabel()
        view.font = .font(.openSans, .semiBold, size: AppSize.getSize(.secondary))
        view.textColor = AppColor.getColor(.head)
        view.textAlignment = .natural
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var thirdLabel: UILabel = {
        let view = UILabel()
        view.font = .font(.openSans, .semiBold, size: AppSize.getSize(.secondary))
        view.textColor = AppColor.getColor(.body)
        view.textAlignment = .natural
        view.numberOfLines = 0
        return view
    }()
    
    var productModel: ProductItem? {
        didSet {
            feedProductView(by: productModel)
            setupView()
        }
    }
    
    // Internal Methods
    var suggestedProductModel: SuggestedProductItem? {
        didSet {
            feedSuggestedProductView(by: suggestedProductModel)
            setupView()
        }
    }
    
    // MARK: Private Methods
    private func setupView() {
        backgroundColor = AppColor.getColor(.white)
        addSubview(imageView)
        addSubview(firstLabel)
        addSubview(secondLabel)
        addSubview(thirdLabel)
        
        imageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        firstLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        secondLabel.snp.makeConstraints { make in
            make.top.equalTo(firstLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        thirdLabel.snp.makeConstraints { make in
            make.top.equalTo(secondLabel.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    //MARK: - Internal Methods
    private func feedSuggestedProductView(by suggestedProductModel: SuggestedProductItem?) {
        guard let suggestedProductModel else { return }
        firstLabel.text = suggestedProductModel.priceText
        secondLabel.text = String(suggestedProductModel.name.prefix(15))
        thirdLabel.text = suggestedProductModel.priceText
        var newImageUrl = suggestedProductModel.imageURL == nil ? suggestedProductModel.squareThumbnailURL : suggestedProductModel.imageURL
        if newImageUrl?.prefix(5) != "https" {
            newImageUrl?.insert("s", at: 4)
        }
        guard let url = URL(string: newImageUrl ?? "") else { return }
        imageView.kf.setImage(with: url)
    }
    
    private func feedProductView(by productModel: ProductItem?) {
        guard let productModel else { return }
        firstLabel.text = productModel.priceText
        secondLabel.text = String(productModel.name.prefix(15))
        thirdLabel.text = productModel.attribute
        var newImageUrl = productModel.imageURL
        if newImageUrl.prefix(5) != "https" {
            newImageUrl.insert("s", at: 4)
        }
        guard let url = URL(string: newImageUrl) else { return }
        imageView.kf.setImage(with: url)
    }
}
