//
//  BaseSection.swift
//  BaseCollection
//
//  Created by Boris Bugor on 19/08/2023.
//

import UIKit

protocol BaseSection {
    var numberOfElements: Int { get }

    func registrate(collectionView: UICollectionView)
    func cell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func header(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView
    func footer(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView
    func section() -> NSCollectionLayoutSection
    func select(row: Int)
}
