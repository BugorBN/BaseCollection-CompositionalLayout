//
//  Section.swift
//  BaseCollection
//
//  Created by Boris Bugor on 19/08/2023.
//

import UIKit

class Section<Cell: SectionCell, Header: SectionHeader, Footer: SectionFooter>: BaseSection {
    init(items: [Cell.CellData], headerData: Header.HeaderData? = nil, footerData: Footer.FooterData? = nil) {
        self.items = items
        self.headerData = headerData
        self.footerData = footerData
    }
    
    private(set) var items: [Cell.CellData]
    private let headerData: Header.HeaderData?
    private let footerData: Footer.FooterData?
    
    var numberOfElements: Int {
        items.count
    }
    
    func registrate(collectionView: UICollectionView) {
        collectionView.register(Cell.self)
        collectionView.registerHeader(Header.self)
        collectionView.registerFooter(Footer.self)
    }
    
    func cell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        collectionView
            .dequeue(Cell.self, indexPath: indexPath)?
            .setup(with: items[indexPath.row])
        ?? UICollectionViewCell()
    }
    
    func header(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView {
        collectionView
            .dequeueHeader(Header.self, indexPath: indexPath)?
            .setup(with: headerData)
        ?? UICollectionReusableView()
    }
    
    func footer(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView {
        collectionView
            .dequeueFooter(Footer.self, indexPath: indexPath)?
            .setup(with: footerData)
        ?? UICollectionReusableView()
    }
    
    func section() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: Cell.groupSize())
        
        if let headerItem = Header.headerItem() {
            section.boundarySupplementaryItems.append(headerItem)
        }
        
        if let footerItem = Footer.footerItem() {
            section.boundarySupplementaryItems.append(footerItem)
        }

        return section
    }

    func select(row: Int) {
        items[row].onSelect?()
    }
}
