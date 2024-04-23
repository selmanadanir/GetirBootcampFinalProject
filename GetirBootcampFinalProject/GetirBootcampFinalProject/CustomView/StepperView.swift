//
//  StepperView.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 17.04.2024.
//

import UIKit

protocol StepperViewDelegate: AnyObject {
    func didTappedUpgradeButton(productItem: ProductItem, productCount: Int)
    func didTappedDowngradeButton(productItem: ProductItem, productCount: Int)
}

final class StepperView: UIView {
    
    // MARK: - View
    private lazy var upgradeButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(AppIcon.getIcon(.plus), for: .normal)
        view.backgroundColor = AppColor.getColor(.white)
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        view.shadowColor = AppColor.getColor(.head)
        view.shadowOffset = .zero
        view.shadowOpacity = 0.2
        view.addTarget(self, action: #selector(didTappedUpgradeButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var label: UILabel = {
        let view = UILabel()
        view.text = String(productCount)
        view.font = .font(.openSans, .bold, size: isForBottomBasketButton ? 16 : 14)
        view.textColor = AppColor.getColor(.white)
        view.textAlignment = .center
        view.backgroundColor = AppColor.getColor(.primary)
        view.layer.shadowColor = AppColor.getColor(.head)?.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.1
        return view
    }()
    
    private lazy var downgradeButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(AppIcon.getIcon(.trash), for: .normal)
        view.backgroundColor = AppColor.getColor(.white)
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner,]
        view.shadowColor = AppColor.getColor(.head)
        view.shadowOffset = .zero
        view.shadowOpacity = 0.1
        view.addTarget(self, action: #selector(didTappedDowngradeButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [downgradeButton, label, upgradeButton])
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.layer.shadowColor = AppColor.getColor(.head)?.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.1
        return view
    }()
    
    // MARK: - Private Variable
    private var productCount: Int = 1
    private var isForBottomBasketButton: Bool
    
    // MARK: - Internal Variable
    weak var delegate: StepperViewDelegate?
    
    var productItem: ProductItem? {
        didSet {
//            setupView()
        }
    }
    
    var suggestProductItem: SuggestedProductItem? {
        didSet {
//            setupView()
        }
    }
    
    // MARK: - Init
    init(isForBottomBasketButton: Bool) {
        self.isForBottomBasketButton = isForBottomBasketButton
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupView() {
        addSubview(stackView)
        
        if isForBottomBasketButton {
            stackView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
                make.width.equalTo(150)
                make.height.equalTo(50)
            }
        } else {
            stackView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
                make.width.equalTo(90)
                make.height.equalTo(30)
            }
        }
    }
    
    @objc private func didTappedUpgradeButton() {
        guard let productItem else { return }
        delegate?.didTappedUpgradeButton(productItem: productItem, productCount: productCount)
        label.text = String(productCount)
        if productCount < 5 {
            productCount += 1
            downgradeButton.setImage(AppIcon.getIcon(.minus), for: .normal)
        }
        label.text = String(productCount)
    }
    
    @objc private func didTappedDowngradeButton() {
        guard let productItem else { return }
        delegate?.didTappedDowngradeButton(productItem: productItem, productCount: productCount)
        if productCount > 1 {
            productCount -= 1
        }
        if productCount == 1 {
            downgradeButton.setImage(AppIcon.getIcon(.trash), for: .normal)
        }
        label.text = String(productCount)
    }
}
