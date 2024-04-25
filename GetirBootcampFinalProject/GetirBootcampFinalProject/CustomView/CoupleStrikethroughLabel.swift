//
//  CoupleStrikethroughLabel.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 22.04.2024.
//

import UIKit

protocol CoupleStrikethroughLabelDelegate: AnyObject {
    func tappedCoupleStrikethroughLabel()
}

final class CoupleStrikethroughLabel: UIView {
    
    // MARK: - View
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.getColor(.white)
        view.shadowRadius = 5
        view.shadowColor = AppColor.getColor(.head)
        view.shadowOffset = .zero
        view.shadowOpacity = 0.1
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private lazy var feeStrikethroughLabel: UILabel = {
        let view = UILabel()
        view.font = .font(.openSans, .medium, size: 12)
        view.textColor = AppColor.getColor(.body)
        view.textAlignment = .center
        view.isEnabled = true
        view.text = "₺200,00"
        view.strikeThrough(true)
        return view
    }()
    
    private lazy var feeLabel: UILabel = {
        let view = UILabel()
        view.font = .font(.openSans, .bold, size: 20)
        view.textColor = AppColor.getColor(.primary)
        view.textAlignment = .center
        view.isEnabled = true
        view.text = "₺1.500,00"
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [feeStrikethroughLabel, feeLabel])
        view.distribution = .fillEqually
        view.axis = .vertical
        view.spacing = 0
        return view
    }()
    
    // MARK: - Internal Method
    weak var delegate: CoupleStrikethroughLabelDelegate?
    
    var amount: Int? {
        didSet {
            feed(by: amount ?? 0)
        }
    }
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setTapGesture()
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
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.snp.edges).inset(8)
        }
    }
    
    private func feed(by amount: Int) {
        feeLabel.text = String(amount)
    }
    
    private func setTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedCoupleStrikethroughLabel))
        stackView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tappedCoupleStrikethroughLabel(){
        delegate?.tappedCoupleStrikethroughLabel()
    }
}
