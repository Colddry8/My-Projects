//
//  Bannerheader.swift
//  DeliveryApp
//
//  Created by Денис Глущенко on 16/1/2567 BE.
//

import UIKit

class BannerHeader: UICollectionReusableView {
    var collectionView: UICollectionView!
    
    static let identifier = "BannerHeader"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        collectionView.dataSource = self
//        collectionView.delegate = self
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
        
        collectionView.register(bannerViewCell.self, forCellWithReuseIdentifier: "bannerViewCell")
    }
    
    func setupLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(300),
                    heightDimension: .absolute(112))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(300),
                    heightDimension: .absolute(112))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.interGroupSpacing = 16

                let layout = UICollectionViewCompositionalLayout(section: section)
                return layout
    }
}



extension BannerHeader: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerViewCell", for: indexPath) as! bannerViewCell
        cell.imageBanner.image = UIImage(named: bannerImages[indexPath.row])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bannerImages.count
    }
}
