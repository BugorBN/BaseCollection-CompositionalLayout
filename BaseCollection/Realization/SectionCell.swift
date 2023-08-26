//
//  SectionCell.swift
//  BaseCollection
//
//  Created by Boris Bugor on 19/08/2023.
//

import UIKit

protocol SectionCell: UICollectionViewCell {
    associatedtype CellData: SectionCellData

    func setup(with data: CellData) -> Self
    static func groupSize() -> NSCollectionLayoutGroup
}

protocol SectionCellData {
    var onSelect: VoidClosure? { get }
}

typealias VoidClosure = () -> Void
