//
//  DetailViewController.swift
//  RickAndMortyApp
//
//  Created by Денис Глущенко on 22/8/2566 BE.
//

import Foundation
import UIKit

class DetailViewController: UIViewController  {
    
    var infoLabel: UILabel!
    var detailCollectionView: UICollectionView!
    var backButton = UIButton()
    var layout: UICollectionViewFlowLayout!
    var characterImage: UIImageView!
    var nameLabel: UILabel!
    var statusLabel: UILabel!
    var Headers = ["Info", "Origin", "Episodes"]
    var CharacterId: Int?
    var origin: RAMOrigin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupButton()
        setupImage()
        setupNameLabel()
        setupStatusLabel()
        setupCollectionView()
        detailCollectionView.dataSource = self
        detailCollectionView.delegate = self
    }
    
    func setupButton() {
        view.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(named: "chevron-left.png"), for: .normal)
        NSLayoutConstraint.activate( [
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
        ])
        
        backButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func buttonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupCollectionView() {
        detailCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())

        view.addSubview(detailCollectionView)
        detailCollectionView.backgroundColor = UIColor(red: 4.0/255, green: 12.0/255, blue: 30.0/255, alpha: 1.0)
        detailCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate( [
            detailCollectionView.topAnchor.constraint(equalTo: statusLabel.topAnchor, constant: 24),
            detailCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            detailCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        detailCollectionView.dataSource = self

        detailCollectionView.register(InfoViewCell.self, forCellWithReuseIdentifier: "DetailCharacterViewCell")
        detailCollectionView.register(OriginViewCell.self, forCellWithReuseIdentifier: "OriginViewCell")
        detailCollectionView.register(EpisodesViewCell.self, forCellWithReuseIdentifier: "EpisodesViewCell")
        detailCollectionView.register(HeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderSupplementaryView")
    }

    


    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
           switch sectionIndex {
           case 0:
               return self.createInfoSection()
           case 1:
               return self.createOriginSection()
           case 2:
               return self.createEpisodesSection()
           default:
               return nil
           }
        }
               return layout
    }
    
    
    func createLayoutSection(group: NSCollectionLayoutGroup, behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior, interGroupSpacing: CGFloat, supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem], contentInsets: Bool) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems

        return section
    }
    
    
    func createInfoSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(124)), subitems: [item])
        group.interItemSpacing = .fixed(15)

        let section = createLayoutSection(group: group,
                                          behavior: .none,
                                          interGroupSpacing: 0,
                                          supplementaryItems: [supplementaryHeaderitem()],
                                          contentInsets: false)
        section.contentInsets = .init(top: 16, leading: 0, bottom: 24, trailing: 0)
        return section
    }
    
    func createOriginSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80)), subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .none,
                                          interGroupSpacing: 0,
                                          supplementaryItems: [supplementaryHeaderitem()],
                                          contentInsets: false)
        section.contentInsets = .init(top: 16, leading: 0, bottom: 24, trailing: 0)
        return section
    }
    
    func createEpisodesSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(86)), subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .none,
                                          interGroupSpacing: 16,
                                          supplementaryItems: [supplementaryHeaderitem()],
                                          contentInsets: false)
        section.contentInsets = .init(top: 16, leading: 0, bottom: 0, trailing: 0)
        return section
    }
    
    func supplementaryHeaderitem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                heightDimension: .estimated(22)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top)
    }
    
    func setupInfoLabel() {
        infoLabel = UILabel()
        view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 313),
            
            infoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            infoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            infoLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
        infoLabel.text = "Info"
        infoLabel.textColor = .white
        infoLabel.font = UIFont(name: infoLabel.font.fontName, size: 17)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func setupImage() {
        
       characterImage = UIImageView(frame: CGRect(x: 113, y: 108, width: 148, height: 148))
        self.view.backgroundColor = UIColor(red: 4.0/255, green: 12.0/255, blue: 30.0/255, alpha: 1.0)
        self.view.addSubview(characterImage)
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        characterImage.layer.masksToBounds = true
        characterImage.layer.cornerRadius = 16
        characterImage.contentMode = .scaleAspectFit
        getData(from: URL(string: CharacterModel.data[CharacterId!].image)!) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.characterImage.image = UIImage(data: data)
                
            }
        }
        
        
        
        NSLayoutConstraint.activate([
            characterImage.widthAnchor.constraint(equalToConstant: 148),
            characterImage.heightAnchor.constraint(equalToConstant: 148),
            characterImage.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10),
            characterImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    func setupLabel(label: UILabel, text: String, color: UIColor, font: CGFloat, textAligment: NSTextAlignment) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.textAlignment = textAligment
        label.text = text
        label.textColor = color
        label.font = UIFont(name: label.font.fontName, size: font)
        self.view.addSubview(label)
        
    }
    func setupNameLabel() {
        nameLabel = UILabel()
        setupLabel(label: nameLabel, text: CharacterModel.data[CharacterId!].name, color: .white, font: 22, textAligment: .center)
        nameLabel.frame = CGRect(x: 119, y: 280, width: 138, height: 25)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 24),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func setupStatusLabel() {
        statusLabel = UILabel()
        setupLabel(label: statusLabel, text: CharacterModel.data[CharacterId!].status, color: .green, font: 16, textAligment: .center)
        statusLabel.frame = CGRect(x: 170, y: 331, width: 34, height: 20)
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func getEpisodeAndSeasonNumber(name: String) -> String {
        let seasonEpisodeString = name.split(separator: "E")
        var seasonSubstring = seasonEpisodeString[0]
        var episodeSubstring = seasonEpisodeString[1]
        print(seasonEpisodeString)
        let removeCharacters: Set<Character> = ["S", "0", "E"]
        seasonSubstring.removeAll(where: {removeCharacters.contains($0)})
        episodeSubstring.removeAll(where: {removeCharacters.contains($0)})
        let season = String(seasonSubstring)
        let episode = String(episodeSubstring)
        let fullString = "Episode: \(episode), Season: \(season)"
        return fullString
    }
}
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderSupplementaryView", for: indexPath) as! HeaderSupplementaryView
            header.headerLabel.text = Headers[indexPath.section]
            return header
        default:
            return UICollectionReusableView()
        }
    }
    

        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 3
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return CharacterModel.data[CharacterId!].episode.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.section {
        case 0:
            guard let cellInfo = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCharacterViewCell", for: indexPath) as? InfoViewCell else {
                return UICollectionViewCell()
            }
            cellInfo.genderText.text = CharacterModel.data[CharacterId!].gender
            cellInfo.speciesText.text = CharacterModel.data[CharacterId!].species
            if CharacterModel.data[CharacterId!].type == "" {
                cellInfo.typeText.text = "None"
            } else {
                cellInfo.typeText.text = CharacterModel.data[CharacterId!].type
            }
            return cellInfo
        case 1:
            guard let cellOrigin = collectionView.dequeueReusableCell(withReuseIdentifier: "OriginViewCell", for: indexPath) as? OriginViewCell else {
                return UICollectionViewCell()
            }
            cellOrigin.originName.text = CharacterModel.data[CharacterId!].origin.name
            cellOrigin.originName.text = origin?.name
            
            if let url = URL(string: CharacterModel.data[CharacterId!].origin.url) {
                RickAndMortyClient.getOriginInformation(url: url) { origin, error in
                    cellOrigin.originName.text = origin.name
                    cellOrigin.originType.text = origin.type
                }
            } else {
                cellOrigin.originName.text = "None"
                cellOrigin.originType.text = "None"
            }
            
            return  cellOrigin
        case 2:
            guard let cellEpisodes = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodesViewCell", for: indexPath) as? EpisodesViewCell else {
                return UICollectionViewCell()
            }
            let url = URL(string: CharacterModel.data[CharacterId!].episode[indexPath.row])!
            RickAndMortyClient.getEpisodeInformation(url: url) { episode, error in
                cellEpisodes.episodeName.text = episode.name
                cellEpisodes.episodeNumber.text = self.getEpisodeAndSeasonNumber(name: episode.episode)
                cellEpisodes.episodeDate.text = episode.air_date
            }
            
            return  cellEpisodes
        default: return UICollectionViewCell()
        }
    }
    
}
