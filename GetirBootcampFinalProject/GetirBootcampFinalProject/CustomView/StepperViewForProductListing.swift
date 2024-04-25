//
//  StepperViewForProductListing.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 22.04.2024.
//

import UIKit

protocol StepperViewForProductListingProtocol: AnyObject {
    func didTappedUpgradeButton(productItem: ProductItem, productCount: Int)
    func didTappedDowngradeButton(productItem: ProductItem, productCount: Int)
}

final class StepperViewForProductListing: UIView {
    
    // MARK: - View
    private lazy var upgradeButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(AppIcon.getIcon(.plus), for: .normal)
        view.backgroundColor = AppColor.getColor(.white)
        view.layer.cornerRadius = 8
        view.shadowColor = AppColor.getColor(.head)
        view.shadowOffset = .zero
        view.shadowOpacity = 0.2
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
        view.layer.shadowColor = AppColor.getColor(.head)?.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.1
        view.isHidden = true
        return view
    }()
    
    private lazy var downgradeButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(AppIcon.getIcon(.trash), for: .normal)
        view.backgroundColor = AppColor.getColor(.white)
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.isHidden = true
        view.shadowColor = AppColor.getColor(.head)
        view.shadowOffset = .zero
        view.shadowOpacity = 0.1
        view.addTarget(self, action: #selector(didTappedDowngradeButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [upgradeButton, label, downgradeButton])
        view.axis = .vertical
        view.distribution = .fillEqually
        view.layer.shadowColor = AppColor.getColor(.head)?.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.1
        return view
    }()
    
    // MARK: - Private Variable
    private var productCount: Int = 0
    
    // MARK: - Internal Variable
    weak var delegate: StepperViewForProductListingProtocol?
    
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupView() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    
    private func updateSetupForUpgradeView() {
        stackView.snp.updateConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(90)
        }
    }
    
    private func updateSetupForDowngradeView() {
        stackView.snp.updateConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    
    @objc private func didTappedUpgradeButton() {
        
        guard let productItem else { return }
        delegate?.didTappedUpgradeButton(productItem: productItem, productCount: productCount)
        label.isHidden = false
        downgradeButton.isHidden = false
        updateSetupForUpgradeView()
        if productCount < 5 {
            productCount += 1
        }
        if productCount > 1 {
            downgradeButton.setImage(AppIcon.getIcon(.minus), for: .normal)
        }
        label.text = String(productCount)
        upgradeButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
    }
    
    @objc private func didTappedDowngradeButton() {
        
        guard let productItem else { return }
        delegate?.didTappedDowngradeButton(productItem: productItem, productCount: productCount)
        if productCount > 1 {
            productCount -= 1
        } else if productCount == 1 {
            productCount = 0
            label.isHidden = true
            downgradeButton.isHidden = true
            updateSetupForDowngradeView()
            upgradeButton.layer.maskedCorners = [.layerMinXMinYCorner ,.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
        if productCount == 1 {
            downgradeButton.setImage(AppIcon.getIcon(.trash), for: .normal)
        }
        label.text = String(productCount)
    }
}
