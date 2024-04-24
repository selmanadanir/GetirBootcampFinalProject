//
//  ShoppingCardViewController.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 22.04.2024.
//

import UIKit

protocol ShoppingCardViewControllerProtocol: AnyObject {
    func setTitle()
    func showDetailScreen()
    func reloadData()
    func showError()
    func setLeftBarButton()
    func setRightBarButton()
    func configureCollectionView()
}

final class ShoppingCardViewController: UIViewController {
    
    // MARK: - View
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView()
        return view
    }()
    
    private lazy var complateOrderButton: ComplateOrderButtonView = {
        let view = ComplateOrderButtonView()
        view.delegate = self
        return view
    }()
    
    private lazy var complateOrderMessage: UILabel = {
        let view = UILabel()
        view.font = .font(.openSans, .semiBold, size: 24)
        view.textColor = AppColor.getColor(.primary)
        view.text = "Siparişiniz Alınmıştır."
        view.isHidden = true
        return view
    }()
    
    // MARK: - Internal Variable
    var presenter: ShoppingCardPresenterProtocol!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        collectionView.dataSource = self
    }
    
    // MARK: - Private Method
    private func setupView() {
        view.addSubview(complateOrderButton)
        view.addSubview(complateOrderMessage)
        
        complateOrderButton.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        complateOrderMessage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    @objc private func tappedLeftBarButton(){
//        navigationController?.popViewController(animated: true)
        print(presenter.getProductsFirebase(index: 0))
    }
    
    @objc private func tappeRigtBarButton(){
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - ShoppingCardViewControllerProtocol
extension ShoppingCardViewController: ShoppingCardViewControllerProtocol {
    
    func setTitle() {
        title = AppText.getText(.shoppingCardTitle)
    }
    
    func showDetailScreen() {
        print("ShoppingCardViewController")
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showError() {
        print("Beklenmeyen bir hata oluştu.")
    }
    
    func setLeftBarButton() {
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "multiply"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(tappedLeftBarButton))
        self.navigationController?.navigationBar.tintColor = AppColor.getColor(.white)
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    func setRightBarButton() {
        let rightBarButton = UIBarButtonItem(image: AppIcon.getIcon(.trash, AppColor.getColor(.white)),
                                             style: .plain,
                                             target: self,
                                             action: #selector(tappeRigtBarButton))
        self.navigationController?.navigationBar.tintColor = AppColor.getColor(.white)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: LayoutManger.generateShoppingCardCollectionLayout())
        view.addSubview(collectionView)
        collectionView.register(ShoppingCardCollectionViewCell.self, forCellWithReuseIdentifier: "BasketDirection.horizontal.name")
        collectionView.register(ProductListCollectionViewCell.self, forCellWithReuseIdentifier: BasketDirection.vertical.name)
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = AppColor.getColor(.white)
    }
}

// MARK: - UICollectionViewDataSource
extension ShoppingCardViewController: UICollectionViewDataSource {
    // MARK: - NumberOfSections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return BasketDirection.allCases.count
    }
    
    // MARK: NumberOfItems
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionKind = BasketDirection(rawValue: section) else { fatalError() }
        switch sectionKind {
        case .horizontal:
            return 3
        case .vertical:
            return presenter.getProductsCount()
        }
    }
    
    // MARK: - CellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let sectionKind = BasketDirection(rawValue: indexPath.section) else { fatalError() }
        
        switch sectionKind {
        case .horizontal:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasketDirection.horizontal.name", for: indexPath) as! ShoppingCardCollectionViewCell
            
            
            let model = ProductItem(id: "6540f93a48e4bd7bf4940ffd",
                                    name: "Kızılay Erzincan & Misket Limonu ve Nane Aromalı İçecek İkilisi",
                                    attribute: "2 Products",
                                    thumbnailURL: "https://market-product-images-cdn.getirapi.com/product/62a59d8a-4dc4-4b4d-8435-643b1167f636.jpg",
                                    imageURL: "https://market-product-images-cdn.getirapi.com/product/62a59d8a-4dc4-4b4d-8435-643b1167f636.jpg",
                                    price: 65.3,
                                    priceText: "₺65,30",
                                    shortDescription: "")
            cell.productModel = model
            
            return cell
            
        case .vertical:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasketDirection.vertical.name, for: indexPath) as! ProductListCollectionViewCell
            
            
            let model = ProductItem(id: "6540f93a48e4bd7bf4940ffd",
                                    name: "Kızılay Erzincan & Misket Limonu ve Nane Aromalı İçecek İkilisi",
                                    attribute: "2 Products",
                                    thumbnailURL: "https://market-product-images-cdn.getirapi.com/product/62a59d8a-4dc4-4b4d-8435-643b1167f636.jpg",
                                    imageURL: "https://market-product-images-cdn.getirapi.com/product/62a59d8a-4dc4-4b4d-8435-643b1167f636.jpg",
                                    price: 65.3,
                                    priceText: "₺65,30",
                                    shortDescription: "")
//            cell.productModel = model
            
            guard let test = presenter.getProductsFirebase(index: indexPath.row) else { return UICollectionViewCell() }
            cell.productModel = test
            
            return cell
        }
    }
}

// MARK: - ComplateOrderButtonViewDelegate
extension ShoppingCardViewController: ComplateOrderButtonViewDelegate {
    func tappedComplateOrderButton() {
        collectionView.isHidden = true
        complateOrderButton.isHidden = true
        complateOrderMessage.isHidden = false
    }
}
