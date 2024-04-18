//
//  CustomStepperView.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 17.04.2024.
//

import UIKit

protocol CustomStepperViewFirstDelegate: AnyObject {
    func didTappedFirstButton()
}

protocol CustomStepperViewSecondDelegate: AnyObject {
    func didTappedSecondButton()
}

final class CustomStepperView: UIView {
    
    // View
    private lazy var firstButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(AppIcon.getIcon(.plus), for: .normal)
        view.backgroundColor = AppColor.getColor(.white)
        view.layer.cornerRadius = 8
        view.backgroundColor = AppColor.getColor(.white)
        view.addTarget(self, action: #selector(didTappedFirstButton), for: .touchUpInside)
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
    
    private lazy var secondButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(AppIcon.getIcon(.trash), for: .normal)
        view.backgroundColor = AppColor.getColor(.white)
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.backgroundColor = AppColor.getColor(.white)
        view.isHidden = true
        view.addTarget(self, action: #selector(didTappedSecondButton), for: .touchUpInside)
        return view
    }()
    
    // MARK: Private Variable
    private var productCount: Int = 1
    
    // MARK: Internal Variable
    weak var firstDelegate: CustomStepperViewFirstDelegate?
    weak var secondDelegate: CustomStepperViewSecondDelegate?
    
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
        addSubview(firstButton)
        addSubview(label)
        addSubview(secondButton)
        
        firstButton.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(firstButton.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        secondButton.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
    
    @objc private func didTappedFirstButton() {
        firstDelegate?.didTappedFirstButton()
        label.isHidden = false
        secondButton.isHidden = false
        label.text = String(productCount)
        if productCount < 5 {
            productCount += 1
        }
        firstButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    @objc private func didTappedSecondButton() {
        secondDelegate?.didTappedSecondButton()
        if productCount > 1 {
            productCount -= 1
        } else if productCount == 1 {
            label.isHidden = true
            secondButton.isHidden = true
            firstButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner,
                .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
        label.text = String(productCount)
    }
}
