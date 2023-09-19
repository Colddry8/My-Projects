//
//  CharacterViewCell.swift
//  RickAndMortyApp
//
//  Created by Денис Глущенко on 19/8/2566 BE.
//

import Foundation
import UIKit
class CharacterViewCell: UICollectionViewCell {
    
    var nameLabel: UILabel!
    let characterImage = UIImageView()
    var activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup() {
        contentView.layer.cornerRadius = 16
        contentView.backgroundColor =  UIColor(red: 38.0/255, green: 42.0/255, blue: 56.0/255, alpha: 1.0)
        
        self.contentView.addSubview(characterImage)
        self.contentView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.layer.masksToBounds = true
        activityIndicator.startAnimating()
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        characterImage.layer.masksToBounds = true
        characterImage.layer.cornerRadius = 10
        characterImage.contentMode = .scaleAspectFit
        
        
        self.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            characterImage.widthAnchor.constraint(equalToConstant: 140),
            characterImage.heightAnchor.constraint(equalToConstant: 50),
            characterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            characterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -8),
            characterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            characterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -54),
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 69)
        ])
    }
    
    func setupLabel() {
        nameLabel = UILabel()
        self.contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 164),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 29),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
        ])
        nameLabel.text = "Rick"
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: nameLabel.font.fontName, size: 17)
    }
    override  func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 16
        
    }
    
    
    

}
