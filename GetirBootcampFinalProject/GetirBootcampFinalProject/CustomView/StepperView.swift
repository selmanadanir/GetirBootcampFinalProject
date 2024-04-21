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
        view.setImage(isVertical ? AppIcon.getIcon(.plus) : AppIcon.getIcon(.trash), for: .normal)
        view.backgroundColor = AppColor.getColor(.white)
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = isVertical ? [.layerMinXMinYCorner ,.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner] : [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        view.shadowColor = AppColor.getColor(.head)
        view.shadowOffset = .zero
        view.shadowOpacity = 0.2
        view.addTarget(self, action: #selector(didTappedUpgradeButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var label: UILabel = {
        let view = UILabel()
        view.text = String(productCount)
        view.font = .font(.openSans, .bold, size: isVertical ? 12 : 16)
        view.textColor = AppColor.getColor(.white)
        view.textAlignment = .center
        view.backgroundColor = AppColor.getColor(.primary)
        view.layer.shadowColor = AppColor.getColor(.head)?.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.1
        view.isHidden = isVertical
        return view
    }()
    
    private lazy var downgradeButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(isVertical ? AppIcon.getIcon(.trash) : AppIcon.getIcon(.plus), for: .normal)
        view.backgroundColor = AppColor.getColor(.white)
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = isVertical ? [.layerMinXMaxYCorner, .layerMaxXMaxYCorner] : [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        view.isHidden = isVertical
        view.shadowColor = AppColor.getColor(.head)
        view.shadowOffset = .zero
        view.shadowOpacity = 0.1
        view.addTarget(self, action: #selector(didTappedDowngradeButton), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Private Variable
    private var productCount: Int = 1
    private var isVertical: Bool
    
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
    init(isVertical: Bool = true) {
        self.isVertical = isVertical
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupView() {
        addSubview(upgradeButton)
        addSubview(label)
        addSubview(downgradeButton)
        
        if isVertical {
            upgradeButton.snp.makeConstraints { make in
                make.leading.top.trailing.equalToSuperview()
                make.width.height.equalTo(30)
            }
            
            label.snp.makeConstraints { make in
                make.top.equalTo(upgradeButton.snp.bottom)
                make.leading.trailing.equalToSuperview()
                make.width.height.equalTo(30)
            }
            
            downgradeButton.snp.makeConstraints { make in
                make.top.equalTo(label.snp.bottom)
                make.leading.bottom.trailing.equalToSuperview()
                make.width.height.equalTo(30)
            }
        } else {
            upgradeButton.snp.makeConstraints { make in
                make.top.leading.bottom.equalToSuperview()
                make.width.height.equalTo(50)
            }
            
            label.snp.makeConstraints { make in
                make.leading.equalTo(upgradeButton.snp.trailing)
                make.top.bottom.equalToSuperview()
                make.width.height.equalTo(50)
            }
            
            downgradeButton.snp.makeConstraints { make in
                make.leading.equalTo(label.snp.trailing)
                make.top.bottom.equalToSuperview()
                make.width.height.equalTo(50)
            }
        }
    }
    
    @objc private func didTappedUpgradeButton() {
        if isVertical {
            guard let productItem else { return }
            delegate?.didTappedUpgradeButton(productItem: productItem, productCount: productCount)
            label.isHidden = false
            downgradeButton.isHidden = false
            label.text = String(productCount)
            if productCount < 5 {
                productCount += 1
            }
            upgradeButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            guard let productItem else { return }
            delegate?.didTappedDowngradeButton(productItem: productItem, productCount: productCount)
            if productCount > 1 {
                productCount -= 1
            }
            label.text = String(productCount)
        }
        
    }
    
    @objc private func didTappedDowngradeButton() {
        if isVertical {
            guard let productItem else { return }
            delegate?.didTappedDowngradeButton(productItem: productItem, productCount: productCount)
            if productCount > 1 {
                productCount -= 1
            }
            label.text = String(productCount)
        } else {
            guard let productItem else { return }
            delegate?.didTappedUpgradeButton(productItem: productItem, productCount: productCount)
            label.isHidden = false
            downgradeButton.isHidden = false
            label.text = String(productCount)
            if productCount < 5 {
                productCount += 1
            }
            upgradeButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }
}
