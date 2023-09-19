//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by Денис Глущенко on 19/8/2566 BE.
//

import UIKit

class MainViewController: UIViewController  {

    var topLabel: UILabel!
    var CharacterCollectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout!
    var b = ["1","2","3","4","5","6","7","8"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 4.0/255, green: 12.0/255, blue: 30.0/255, alpha: 1.0)
        setupCollectionView()
        setupLabel()
        CharacterCollectionView.dataSource = self
        CharacterCollectionView.delegate = self
        RickAndMortyClient.getCharactersInformation { characters, error in
            CharacterModel.data = characters
            self.CharacterCollectionView.reloadData()
            print(characters.count)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setupLabel() {
      topLabel = UILabel()
        view.addSubview(topLabel)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topLabel.bottomAnchor.constraint(equalTo: CharacterCollectionView.topAnchor),
            topLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 29),
            topLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        topLabel.text = "Characters"
        topLabel.textColor = .white
        topLabel.font = UIFont(name: topLabel.font.fontName, size: 28)
    }
    
    func setupCollectionView() {
        layout = setupFlowLayout()
        CharacterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.addSubview(CharacterCollectionView)
        CharacterCollectionView.backgroundColor =  UIColor(red: 4.0/255, green: 12.0/255, blue: 30.0/255, alpha: 1.0)
        CharacterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate( [
            CharacterCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 134),
            CharacterCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            CharacterCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            CharacterCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        CharacterCollectionView.dataSource = self
        
        CharacterCollectionView.register(CharacterViewCell.self, forCellWithReuseIdentifier: "CharacterViewCell")
    }
    
    func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 156, height: 202)
        //layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing =  16
        //layout.minimumInteritemSpacing = 50
        layout.sectionInset = .init(top: 0, left: 10, bottom: 30, right: 10)
        return layout
    }
    
    func handleGetCharacterInformation(data: [RAMCharacterInformation], error: Error?)
    {
        if error == nil
        {
                CharacterModel.data = data
                print(data[1].name)
                self.CharacterCollectionView.reloadData()
            
        } else
        {
            
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        navigationController?.pushViewController(detailViewController, animated: true)
        detailViewController.CharacterId = indexPath.row 
//        present(detailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CharacterModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterViewCell", for: indexPath) as? CharacterViewCell else {
            return UICollectionViewCell()
        }
        getData(from: URL(string: CharacterModel.data[indexPath.row].image)!) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                cell.characterImage.image = UIImage(data: data)
                cell.activityIndicator.isHidden = true
            }
        }
        cell.nameLabel.text = CharacterModel.data[indexPath.row].name
        
        return cell
    }
    
    
}

