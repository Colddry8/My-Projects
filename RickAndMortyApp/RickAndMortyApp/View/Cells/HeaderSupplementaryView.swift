//
//  HeaderSupplementaryView.swift
//  RickAndMortyApp
//
//  Created by Денис Глущенко on 30/8/2566 BE.
//

import Foundation
import UIKit

class HeaderSupplementaryView: UICollectionReusableView {
    let headerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeaderLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupHeaderLabel() {
        addSubview(headerLabel)
        headerLabel.text = "Origin"
        headerLabel.textAlignment = .left
        headerLabel.font = UIFont(name: headerLabel.font.fontName, size: 17)
        headerLabel.textColor = .white
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0)

        ])
    }
    
    
}
