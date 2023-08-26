//
//  ViewController.swift
//  BaseCollection
//
//  Created by Boris Bugor on 19/08/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let sectionView = SectionView()
    
    override func loadView() {
        view = sectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        sectionView.backgroundColor = .white

        sectionView.set(
            sections: [
                Section<DynamicCollectionCell, DefaultSectionHeader, DefaultSectionFooter>(
                    items: [
                        .init(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"),
                        .init(text: "when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."),
                        .init(text: "It was popularised"),
                        .init(text: "the 1960s with the release of Letraset sheets containing"),
                        .init(text: "Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                    ],
                    headerData: "DYNAMIC SECTION",
                    footerData: "footer text for dynamic section"
                ),
                Section<ColorCollectionCell, DefaultSectionHeader, DefaultSectionFooter>(
                    items: [
                        .init(color: .blue) {
                            print(#function)
                        },
                        .init(color: .red) {
                            print(#function)
                        },
                        .init(color: .yellow) {
                            print(#function)
                        },
                        .init(color: .green) {
                            print(#function)
                        },
                        .init(color: .blue) {
                            print(#function)
                        }
                    ],
                    headerData: "COLOR SECTION",
                    footerData: "footer text for color section"
                )
            ],
            append: false
        )
    }
}

class ColorCollectionCell: UICollectionViewCell, SectionCell {

    func setup(with data: ColorCollectionCellData) -> Self {
        contentView.backgroundColor = data.color
        
        return self
    }

    static func groupSize() -> NSCollectionLayoutGroup {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(16)
        return group
    }
}

class ColorCollectionCellData: SectionCellData {
    let onSelect: VoidClosure?
    let color: UIColor
    
    init(color: UIColor, onSelect: VoidClosure? = nil) {
        self.onSelect = onSelect
        self.color = color
    }
}

class DynamicCollectionCell: UICollectionViewCell, SectionCell {
    let textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        contentView.addSubview(textLabel)
        textLabel.numberOfLines = .zero
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            textLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }

    func setup(with data: DynamicCollectionCellData) -> Self {
        textLabel.text = data.text
        
        return self
    }
    
    static func groupSize() -> NSCollectionLayoutGroup {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(20))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
        return group
    }
}

class DynamicCollectionCellData: SectionCellData {
    let text: String
    var onSelect: VoidClosure?
    
    init(text: String) {
        self.text = text
    }
}

class DefaultSectionHeader: UICollectionReusableView, SectionHeader {
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        addSubview(textLabel)
        textLabel.numberOfLines = .zero
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            textLabel.leftAnchor.constraint(equalTo: leftAnchor),
            textLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    func setup(with data: String?) -> Self {
        textLabel.text = data
        
        return self
    }

    static func headerItem() -> NSCollectionLayoutBoundarySupplementaryItem? {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(20))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top,
            absoluteOffset: .zero
        )
        header.pinToVisibleBounds = true
        return header
    }
}

class DefaultSectionFooter: UICollectionReusableView, SectionFooter {
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        addSubview(textLabel)
        textLabel.numberOfLines = .zero
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            textLabel.leftAnchor.constraint(equalTo: leftAnchor),
            textLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    func setup(with data: String?) -> Self {
        textLabel.text = data
        
        return self
    }

    static func footerItem() -> NSCollectionLayoutBoundarySupplementaryItem? {
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(20))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom,
            absoluteOffset: .zero
        )

        return footer
    }
}
