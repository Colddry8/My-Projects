//
//  MenuViewCell.swift
//  DeliveryApp
//
//  Created by Денис Глущенко on 13/1/2567 BE.
//

import UIKit

class menuViewCell: UICollectionViewCell {
    
    var dishImage = UIImageView()
    var nameLabel = UILabel()
    var descriptionText = UITextView()
    var priceButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        setupImage()
        setupLabel()
        setupText()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImage() {
        contentView.addSubview(dishImage)
        dishImage.translatesAutoresizingMaskIntoConstraints = false
        dishImage.image = UIImage(named: "Banner_1")
        
        NSLayoutConstraint.activate([
            dishImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            dishImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dishImage.widthAnchor.constraint(equalToConstant: 132),
            dishImage.heightAnchor.constraint(equalToConstant: 132),
        ])
    }
    
    func setupLabel() {
        contentView.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = resources.Color.label
        nameLabel.font = resources.Font.SF_UI_Display(with: 17, type: .regular)
        
        nameLabel.text = "DishName"
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 180),
//            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            nameLabel.widthAnchor.constraint(equalToConstant: 136),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupText() {
        contentView.addSubview(descriptionText)
        descriptionText.sizeToFit()
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
//        descriptionText.frame.size = contentView.bounds.size
        descriptionText.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        descriptionText.textAlignment = .left
        descriptionText.textColor = resources.Color.textColor
        descriptionText.backgroundColor = .white
        descriptionText.contentInset = UIEdgeInsets(top: -5, left: -5, bottom: -5, right: 0)
        descriptionText.font = resources.Font.SF_UI_Display(with: 13, type: .regular)
        descriptionText.isEditable = false
        descriptionText.isScrollEnabled = false
        NSLayoutConstraint.activate([
            descriptionText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 52),
            descriptionText.leadingAnchor.constraint(equalTo: dishImage.trailingAnchor, constant: 32),
            descriptionText.widthAnchor.constraint(equalToConstant: 171),
            descriptionText.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    func setupButton() {
        contentView.addSubview(priceButton)
        priceButton.translatesAutoresizingMaskIntoConstraints = false
        priceButton.layer.masksToBounds = true
        priceButton.layer.cornerRadius = 6
        priceButton.backgroundColor = .clear
        priceButton.tintColor = .primary
        priceButton.layer.borderWidth = 1
        priceButton.layer.borderColor = CGColor(red: 253/255, green: 58/255, blue: 105/255, alpha: 1)
        priceButton.setTitle("от 345 р", for: .normal)
        priceButton.titleLabel?.font = resources.Font.SF_UI_Display(with: 13, type: .regular)
        priceButton.setTitleColor(.primary, for: .normal)
        
        
        NSLayoutConstraint.activate([
            priceButton.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 16),
            priceButton.leadingAnchor.constraint(equalTo: dishImage.trailingAnchor, constant: 116),
            priceButton.widthAnchor.constraint(equalToConstant: 87),
            priceButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
