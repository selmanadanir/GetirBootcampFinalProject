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
    
    // View
    private lazy var upgradeButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(AppIcon.getIcon(.plus), for: .normal)
        view.backgroundColor = AppColor.getColor(.white)
        view.layer.cornerRadius = 8
        view.backgroundColor = AppColor.getColor(.white)
        view.addTarget(self, action: #selector(didTappedUpgradeButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var label: UILabel = {
        let view = UILabel()
        view.text = String(productCount)
        view.font = .font(.openSans, .bold, size: 12)
        view.textColor = AppColor.getColor(.white)
        view.textAlignment = .center
        view.backgroundColor = AppColor.getColor(.primary)
        view.isHidden = true
        return view
    }()
    
    private lazy var downgradeButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(AppIcon.getIcon(.trash), for: .normal)
        view.backgroundColor = AppColor.getColor(.white)
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.backgroundColor = AppColor.getColor(.white)
        view.isHidden = true
        view.addTarget(self, action: #selector(didTappedDowngradeButton), for: .touchUpInside)
        return view
    }()
    
    // MARK: Private Variable
    private var productCount: Int = 1
    
    // MARK: Internal Variable
    weak var delegate: StepperViewDelegate?
    
    var productItem: ProductItem? {
        didSet {
            setupView()
        }
    }
    
    var suggestProductItem: SuggestedProductItem? {
        didSet {
            setupView()
        }
    }
    
    // MARK: Private Methods
    private func setupView() {
        addSubview(upgradeButton)
        addSubview(label)
        addSubview(downgradeButton)
        
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
    }
    
    @objc private func didTappedUpgradeButton() {
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
    
    @objc private func didTappedDowngradeButton() {
        guard let productItem else { return }
        delegate?.didTappedDowngradeButton(productItem: productItem, productCount: productCount)
        if productCount > 1 {
            productCount -= 1
        } else if productCount == 1 {
            label.isHidden = true
            downgradeButton.isHidden = true
            upgradeButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner,
                .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
        label.text = String(productCount)
    }
}
