//
//  BottomBasketButtonView.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 21.04.2024.
//

import UIKit

protocol BottomBasketButtonViewDelegate: AnyObject {
    func addToBasketButton()
    func didTappedUpgradeButton(productItem: ProductItem, productCount: Int)
    func didTappedDowngradeButton(productItem: ProductItem, productCount: Int)
}

final class BottomBasketButtonView: UIView {
    
    // MARK: - View
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.getColor(.white)
        view.shadowRadius = 5
        view.shadowColor = AppColor.getColor(.head)
        view.shadowOffset = .zero
        view.shadowOpacity = 0.2
        return view
    }()
    
    private lazy var addToBasketButton: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = .font(.openSans, .bold, size: 14)
        view.setTitle(AppText.getText(.addToBasket), for: .normal)
        view.backgroundColor = AppColor.getColor(.primary)
        view.layer.cornerRadius = 8
        view.setTitleColor(AppColor.getColor(.white), for: .normal)
        view.addTarget(self, action: #selector(tappedAddBasketButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var stepperView: StepperView = {
        let view = StepperView(isForBottomBasketButton: true)
        view.isHidden = true
        view.delegate = self
        return view
    }()
    
    // MARK: - Internal Variable
    weak var delegate: BottomBasketButtonViewDelegate?
    var productModel: ProductItem? {
        didSet {
            stepperView.productItem = productModel
        }
    }
    
    var suggestedProductModel: SuggestedProductItem? {
        didSet {
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
    
    // MARK: - Private Method
    private func setupView() {
        addSubview(contentView)
        addSubview(addToBasketButton)
        addSubview(stepperView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(100)
        }
        
        addToBasketButton.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).inset(16)
            make.top.equalTo(contentView.snp.top).inset(16)
            make.trailing.equalTo(contentView.snp.trailing).inset(16)
            make.height.equalTo(50)
        }
        stepperView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(16)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }
    
    @objc private func tappedAddBasketButton() {
        delegate?.addToBasketButton()
        addToBasketButton.isHidden.toggle()
        stepperView.isHidden.toggle()
    }
}

// MARK: - StepperViewDelegate
extension BottomBasketButtonView: StepperViewDelegate {
    func didTappedUpgradeButton(productItem: ProductItem, productCount: Int) {
        delegate?.didTappedUpgradeButton(productItem: productItem, productCount: productCount)
    }
    
    func didTappedDowngradeButton(productItem: ProductItem, productCount: Int) {
        delegate?.didTappedDowngradeButton(productItem: productItem, productCount: productCount)
    }
}
