//
//  BannerViewCell.swift
//  DeliveryApp
//
//  Created by Денис Глущенко on 13/1/2567 BE.
//

import UIKit

class bannerViewCell: UICollectionViewCell {
    
    var imageBanner = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImage()
        contentView.backgroundColor = .brown
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImage() {
        contentView.addSubview(imageBanner)
        imageBanner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageBanner.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageBanner.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageBanner.widthAnchor.constraint(equalToConstant: 300),
            imageBanner.heightAnchor.constraint(equalToConstant: 112)
        ])
    }
}
