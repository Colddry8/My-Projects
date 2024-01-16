//
//  CategoryViewCell.swift
//  DeliveryApp
//
//  Created by Денис Глущенко on 13/1/2567 BE.
//

import UIKit

class categoryViewCell: UICollectionViewCell {
    
    var categoryLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel() {
        contentView.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.layer.masksToBounds = true
        categoryLabel.layer.cornerRadius = 20
        categoryLabel.backgroundColor = .clear
        categoryLabel.tintColor = .unselectedCategory
        categoryLabel.layer.borderWidth = 1
        categoryLabel.layer.borderColor = resources.Color.categoryColor.borderUnselected?.cgColor
        categoryLabel.textColor = .unselectedCategory
        categoryLabel.font = resources.Font.SF_UI_Display(with: 13, type: .regular)
        categoryLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 0),
            categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 0),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 0),
            categoryLabel.widthAnchor.constraint(equalToConstant: 88),
            categoryLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    
    
    func makeSelected() {
        categoryLabel.font = resources.Font.SF_UI_Display(with: 13, type: .bold)
        categoryLabel.textColor = .primary
        categoryLabel.layer.borderWidth = 1
        categoryLabel.layer.borderColor = UIColor.clear.cgColor
        categoryLabel.backgroundColor = .selectedCategory
    }
    
    func makeUnselected() {
        categoryLabel.font = resources.Font.SF_UI_Display(with: 13, type: .regular)
        categoryLabel.textColor = .unselectedCategory
        categoryLabel.layer.borderWidth = 1
        categoryLabel.layer.borderColor = resources.Color.categoryColor.borderUnselected?.cgColor
        categoryLabel.backgroundColor = resources.Color.categoryColor.backgroundUnselected
    }
}
