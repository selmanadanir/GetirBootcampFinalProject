//
//  ComplateOrderButtonView.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 22.04.2024.
//

import UIKit

protocol ComplateOrderButtonViewDelegate: AnyObject {
    func tappedComplateOrderButton()
}

final class ComplateOrderButtonView: UIView {
    
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
    
    private lazy var complateOrderButton: UIButton = {
        let view = UIButton(type: .system)
        view.titleLabel?.font = .font(.openSans, .bold, size: 14)
        view.setTitle(AppText.getText(.addToBasket), for: .normal)
        view.backgroundColor = AppColor.getColor(.primary)
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        view.setTitleColor(AppColor.getColor(.white), for: .normal)
        view.addTarget(self, action: #selector(tappedComplateOrderButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var coupleStrikethroughLabel: CoupleStrikethroughLabel = {
        let view = CoupleStrikethroughLabel()
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [complateOrderButton, coupleStrikethroughLabel])
        view.axis = .horizontal
        view.spacing = 0
        view.distribution = .fill
        return view
    }()
    
    // MARK: - Internal Method
    weak var delegate: ComplateOrderButtonViewDelegate?
    
    var amount: Int? {
        didSet {
            coupleStrikethroughLabel.amount = amount
        }
    }
    
    // MARK: - Life Cycle
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
        addSubview(stackView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(100)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).inset(16)
            make.top.equalTo(contentView.snp.top).inset(16)
            make.trailing.equalTo(contentView.snp.trailing).inset(16)
            make.height.equalTo(50)
        }
    }
    
    @objc private func tappedComplateOrderButton() {
        delegate?.tappedComplateOrderButton()
    }
}
