//
//  BasketAmountView.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 18.04.2024.
//

import UIKit

protocol BasketAmountViewDelegate: AnyObject {
    func clickBasketAmountButton()
}

final class BasketAmountView: UIView {
    
    // MARK: View
    private lazy var basketIconButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(AppIcon.getIcon(.basket), for: .normal)
        view.layer.cornerRadius = 8
        view.backgroundColor = AppColor.getColor(.white)
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        view.addTarget(self, action: #selector(didTappedAmmountButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var ammountButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle("₺0,00", for: .normal)
        view.titleLabel?.font = .font(.openSans, .bold, size: 14)
        view.setTitleColor(AppColor.getColor(.primary), for: .normal)
        view.layer.cornerRadius = 8
        view.backgroundColor = AppColor.getColor(.basketAmount)
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        view.addTarget(self, action: #selector(didTappedAmmountButton), for: .touchUpInside)
        return view
    }()
    
    // MARK: Variable
    weak var delegate: BasketAmountViewDelegate?
    var amount: Double? {
        didSet {
            updateBasketAmount(amount: amount ?? 0)
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
    
    // MARK: Private Method
    private func setupView() {
        addSubview(basketIconButton)
        addSubview(ammountButton)
        
        basketIconButton.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.height.equalTo(34)
        }
        
        ammountButton.snp.makeConstraints { make in
            make.leading.equalTo(basketIconButton.snp.trailing)
            make.top.trailing.bottom.equalToSuperview()
            make.height.equalTo(34)
            make.width.equalTo(57)
        }
    }
    
    @objc private func didTappedAmmountButton() {
        delegate?.clickBasketAmountButton()
    }
    
    private func updateBasketAmount(amount: Double) {
        if amount.round(to: 2).count() < 5 {
            ammountButton.titleLabel?.font = .font(.openSans, .bold, size: 14)
        } else if amount.round(to: 2).count() >= 5 && amount.round(to: 2).count() < 7{
            ammountButton.titleLabel?.font = .font(.openSans, .bold, size: 12)
        } else {
            ammountButton.titleLabel?.font = .font(.openSans, .bold, size: 12)
        }
        ammountButton.setTitle("₺\(amount.round(to: 2))", for: .normal)
    }
}

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Double {
    func count() -> Int {
        if self == Double(Int(self)) {
            return 0
        }

        let doubleString = String(Double(self))
        return doubleString.count - 1
    }
}
