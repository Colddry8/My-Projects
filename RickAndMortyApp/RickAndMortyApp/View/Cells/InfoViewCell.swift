//
//  DetailCharacterViewCell.swift
//  RickAndMortyApp
//
//  Created by Денис Глущенко on 22/8/2566 BE.
//

import Foundation
import UIKit

class InfoViewCell: UICollectionViewCell {
    
    var speciesLabel = UILabel()
    var typeLabel = UILabel()
    var genderLabel = UILabel()
    var speciesText = UILabel()
    var typeText = UILabel()
    var genderText = UILabel()
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(red: 38.0/255, green: 42.0/255, blue: 56.0/255, alpha: 1.0)
        contentView.layer.cornerRadius = 16
        setupSpeciesLabel()
        setupTypeLabel()
        setupGenderLabel()
            }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel(label: UILabel, text: String, color: UIColor, font: CGFloat, textAligment: NSTextAlignment) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.textAlignment = textAligment
        label.text = text
        label.textColor = color
        label.font = UIFont(name: label.font.fontName, size: font)
//        label.frame = frame
        self.contentView.addSubview(label)
        
    }
    
    func setupSpeciesLabel() {
        
        
        setupLabel(label: speciesLabel, text: "Species:", color: .gray, font: 16, textAligment: .left)
        setupLabel(label: speciesText, text: "", color: .white, font: 16, textAligment: .right)
        
        NSLayoutConstraint.activate([
            speciesText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            speciesText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            speciesText.heightAnchor.constraint(equalToConstant: 20),
            speciesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            speciesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            speciesLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupTypeLabel() {
        
        setupLabel(label: typeLabel, text: "Type:", color: .gray, font: 16, textAligment: .left)
        setupLabel(label: typeText, text: "", color: .white, font: 16, textAligment: .right)
        
        NSLayoutConstraint.activate([
            typeText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 52),
            typeText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            typeText.heightAnchor.constraint(equalToConstant: 20),
            typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 52),
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            typeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupGenderLabel() {
        
        setupLabel(label: genderLabel, text: "Gender:", color: .gray, font: 16, textAligment: .left)
        setupLabel(label: genderText, text: "", color: .white, font: 16, textAligment: .right)
        
        NSLayoutConstraint.activate([
            genderText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 88),
            genderText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            genderText.heightAnchor.constraint(equalToConstant: 20),
            genderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 88),
            genderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            genderLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    

}
