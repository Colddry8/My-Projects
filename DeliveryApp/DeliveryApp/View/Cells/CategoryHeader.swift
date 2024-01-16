//
//  CategoryHeader.swift
//  DeliveryApp
//
//  Created by Денис Глущенко on 14/1/2567 BE.
//

import UIKit
protocol CategoryHeaderDelegate: AnyObject {
    func moveToSection(at sectionIndex: Int)
}

class CategoryHeader: UICollectionReusableView {
    
    static let identifier = "CategoryHeader"
    weak var delegate: CategoryHeaderDelegate!
    var canChange = true
    var collectionView: UICollectionView!
    var selectedCategory: Int = 0
    var categories = [
    Category(index: 0, name: "Пицца", isSelected: true),
    Category(index: 1, name: "Комбо", isSelected: false),
    Category(index: 2, name: "Десерты", isSelected: false),
    Category(index: 3, name: "Напитки", isSelected: false)
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupLayout())
        addSubview(collectionView)
        
    
        collectionView.backgroundColor = .background
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate( [
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        collectionView.register(categoryViewCell.self, forCellWithReuseIdentifier: "categoryViewCell")
    }
    
    func setupLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(88),
                    heightDimension: .absolute(32))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(88),
                    heightDimension: .absolute(32))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.interGroupSpacing = 8

                let layout = UICollectionViewCompositionalLayout(section: section)
                return layout
    }
}
extension CategoryHeader: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func unselectCategory() {
        let previousSelectedCell = collectionView.cellForItem(at: IndexPath(row: selectedCategory, section: 0)) as! categoryViewCell
        categories[selectedCategory].isSelected = false
        previousSelectedCell.makeUnselected()
    }
    private func selectCategory(at indexPath: IndexPath) {
        selectedCategory = indexPath.item
        let previousSelectedCell = collectionView.cellForItem(at: indexPath) as! categoryViewCell
        previousSelectedCell.makeSelected()
        categories[indexPath.row].isSelected = true
        moveToCell(with: indexPath)
    }
    
    private func moveToCell(with indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryViewCell", for: indexPath) as? categoryViewCell else {
            return UICollectionViewCell()
        }
        cell.categoryLabel.text = categories[indexPath.row].name
        if categories[indexPath.item].isSelected {
            cell.makeSelected()
        } else {
            cell.makeUnselected()
        }
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        unselectCategory()
        selectCategory(at: indexPath)
        delegate.moveToSection(at: indexPath.item)
    }
}

extension CategoryHeader: MenuViewControllerHeaderDelegate {
    

    func moveToCategory(with index: Int) {
        unselectCategory()
        let indexPath = IndexPath(item: index, section: 0)
        selectCategory(at: indexPath)
    }
}
