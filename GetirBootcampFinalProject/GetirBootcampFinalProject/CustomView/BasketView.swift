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
    
    private lazy var labelStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [firstLabel, secondLabel, thirdLabel])
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 0
        return view
    }()
    
    private lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.getColor(.background)
        return view
    }()
    
    // MARK: - Internal Method
    var productModel: ProductItem? {
        didSet {
            feedProductView(by: productModel)
        }
    }
    
    var suggestedProductModel: SuggestedProductItem? {
        didSet {
            feedSuggestedProductView(by: suggestedProductModel)
        }
    }
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init(isForDetailScreen: Bool) {
        self.init()
        if isForDetailScreen {
            updateViewForProductDetailScreen()
        } else {
            updateViewForShoppingCardScreen()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    private func setupView() {
        
        addSubview(imageView)
        addSubview(labelStackView)
        
        imageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    //MARK: - Internal Methods
    private func feedSuggestedProductView(by suggestedProductModel: SuggestedProductItem?) {
        guard let suggestedProductModel else { return }
        firstLabel.text = suggestedProductModel.priceText
        guard let name = suggestedProductModel.name else { return }
        secondLabel.text = String(name.prefix(15))
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
        guard let name = productModel.name else { return }
        secondLabel.text = String(name.prefix(15))
        thirdLabel.text = productModel.attribute
        var newImageUrl = productModel.imageURL
        if newImageUrl?.prefix(5) != "https" {
            newImageUrl?.insert("s", at: 4)
        }
        guard let url = URL(string: newImageUrl ?? "") else { return }
        imageView.kf.setImage(with: url)
    }
    
    private func updateViewForProductDetailScreen() {
        imageView.layer.borderWidth = 0
        imageView.layer.cornerRadius = 0
        firstLabel.font = .font(.openSans, .bold, size: 20)
        firstLabel.textAlignment = .center
        
        secondLabel.font = .font(.openSans, .semiBold, size: 16)
        secondLabel.textAlignment = .center
        
        thirdLabel.font = .font(.openSans, .semiBold, size: 12)
        thirdLabel.textAlignment = .center
        
        imageView.snp.updateConstraints { make in
            make.height.width.equalTo(200)
        }
        
        addSubview(bottomLine)
        
        bottomLine.snp.makeConstraints { make in
            make.top.equalTo(labelStackView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
    }
    
    private func updateViewForShoppingCardScreen() {
        labelStackView.arrangedSubviews[2].removeFromSuperview()
        labelStackView.arrangedSubviews[1].removeFromSuperview()
        labelStackView.arrangedSubviews[0].removeFromSuperview()
        
        addSubview(imageView)
        addSubview(labelStackView)
        
        labelStackView.addArrangedSubview(secondLabel)
        labelStackView.addArrangedSubview(thirdLabel)
        labelStackView.addArrangedSubview(firstLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.height.width.equalTo(75)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing)
            make.top.equalTo(imageView.snp.top)
        }
        
        layoutIfNeeded()
    }
}
