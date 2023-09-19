//
//  episodesViewCell.swift
//  RickAndMortyApp
//
//  Created by Денис Глущенко on 29/8/2566 BE.
//

import Foundation
import UIKit


class EpisodesViewCell: UICollectionViewCell {
    
    var episodeName = UILabel()
    var episodeNumber = UILabel()
    var episodeDate = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(red: 38.0/255, green: 42.0/255, blue: 56.0/255, alpha: 1.0)
        contentView.layer.cornerRadius = 16
        
        setupEpisodeName()
        setupEpisodeNumber()
        setupEpisodeDate()
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
        self.contentView.addSubview(label)
        
    }
    
    func setupEpisodeName() {
        
        setupLabel(label: episodeName,
                   text: "Name",
                   color: .white,
                   font: 17,
                   textAligment: .left)
       
        
        NSLayoutConstraint.activate([
            episodeName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            episodeName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.25),
            episodeName.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func setupEpisodeNumber() {
        
        setupLabel(label: episodeNumber,
                   text: "Episode: _, Season: _",
                   color: .green, font: 13,
                   textAligment: .left)
        
        NSLayoutConstraint.activate([
            episodeNumber.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 54),
            episodeNumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.25),
            episodeNumber.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func setupEpisodeDate() {
        
        setupLabel(label: episodeDate,
                   text: "Date",
                   color: .lightGray,
                   font: 12,
                   textAligment: .left)
       
        
        NSLayoutConstraint.activate([
            episodeDate.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 54),
            episodeDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.68),
            episodeDate.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    
}
