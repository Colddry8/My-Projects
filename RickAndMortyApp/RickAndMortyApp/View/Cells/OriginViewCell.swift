//
//  OriginViewCell.swift
//  RickAndMortyApp
//
//  Created by Денис Глущенко on 23/8/2566 BE.
//

import Foundation
import UIKit

class OriginViewCell: UICollectionViewCell {
    
    var originName = UILabel()
    var originType = UILabel()
    var backgroundImage = UIImageView()
    var originImage = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(red: 38.0/255, green: 42.0/255, blue: 56.0/255, alpha: 1.0)
        contentView.layer.cornerRadius = 16
        
        setupNameLabel()
        setupTypeLabel()
        setupBackgroundImage()
        setupImage()
            }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBackgroundImage() {
        self.contentView.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.layer.masksToBounds = true
        backgroundImage.layer.cornerRadius = 10
        backgroundImage.contentMode = .scaleAspectFit
        backgroundImage.image = UIImage(named: "backImage.png")
        
        self.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            backgroundImage.widthAnchor.constraint(equalToConstant: 64),
            backgroundImage.heightAnchor.constraint(equalToConstant: 64),
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
        ])
    }
    
    func setupImage() {
        
        self.contentView.addSubview(originImage)
        originImage.translatesAutoresizingMaskIntoConstraints = false
        originImage.layer.masksToBounds = true
        originImage.layer.cornerRadius = 10
        originImage.contentMode = .scaleAspectFit
        originImage.image = UIImage(named: "Planet.png")
    
        self.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            originImage.widthAnchor.constraint(equalToConstant: 24),
            originImage.heightAnchor.constraint(equalToConstant: 24),
            originImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            originImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28),
        ])
    }
    
    func setupLabel(label: UILabel, text: String, color: UIColor, font: CGFloat, textAligment: NSTextAlignment) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.textAlignment = textAligment
        label.text = text
        label.textColor = color
        label.font = UIFont(name: label.font.fontName, size: font)
        self.contentView.addSubview(label)
        
    }
    
    func setupNameLabel() {
        
        setupLabel(label: originName,
                   text: "",
                   color: .white, font: 17,
                   textAligment: .left)
        
        NSLayoutConstraint.activate([
            originName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            originName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 88),
            originName.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func  setupTypeLabel() {
        
        setupLabel(label: originType,
                   text: "",
                   color: .green,
                   font: 13,
                   textAligment: .left)
      
        
        NSLayoutConstraint.activate([
            originType.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 46),
            originType.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 88),
            originType.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    
    
}
