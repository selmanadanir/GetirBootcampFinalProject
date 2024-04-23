//
//  LayoutManger.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 14.04.2024.
//

import UIKit

final class LayoutManger {
    
    static func generateProductsListingCollectionLayout(isWide: Bool) -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnviroment -> NSCollectionLayoutSection? in
            guard let sectionKind = BasketDirection(rawValue: sectionIndex) else { return nil }
            
            switch sectionKind {
            case .horizontal:
                // ITEM
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10)
                
                
                // GROUP
                let banerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(isWide ? 0.21 : 0.26))
                let banerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: banerGroupSize, subitem: item, count: 1)
                
                
                // SECTION
                let section = NSCollectionLayoutSection(group: banerGroup)
                section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 30, trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
                return section
                
            case .vertical:
                // ITEM
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 15)
                
                // GROUP
                let itemGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(isWide ? 0.21 : 0.26))
                let itemGroup = NSCollectionLayoutGroup.horizontal(layoutSize: itemGroupSize, subitem: item, count: 3)
                itemGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0)
                
                // SECTION
                let section = NSCollectionLayoutSection(group: itemGroup)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 0)
                return section
            }
        }
        return layout
    }
    
    static func generateShoppingCardCollectionLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnviroment -> NSCollectionLayoutSection? in
            guard let sectionKind = BasketDirection(rawValue: sectionIndex) else { return nil }
            
            switch sectionKind {
            case .horizontal:
                // ITEM
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 15)
                
                // GROUP
                let itemGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.17))
                let itemGroup = NSCollectionLayoutGroup.horizontal(layoutSize: itemGroupSize, subitem: item, count: 1)
                itemGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0)
                
                // SECTION
                let section = NSCollectionLayoutSection(group: itemGroup)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 0)
                return section
                
            case .vertical:
                
                // ITEM
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10)
                
                
                // GROUP
                let banerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.26))
                let banerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: banerGroupSize, subitem: item, count: 1)
                
                
                // SECTION
                let section = NSCollectionLayoutSection(group: banerGroup)
                section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 30, trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
                return section
            }
        }
        return layout
    }
}
