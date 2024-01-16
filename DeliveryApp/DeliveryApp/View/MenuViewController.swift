//
//  ViewController.swift
//  DeliveryApp
//
//  Created by Денис Глущенко on 13/1/2567 BE.
//
import Foundation
import UIKit

protocol MenuViewControllerHeaderDelegate: AnyObject {
    var canChange: Bool { get set }
    func moveToCategory(with index: Int)
}


class MenuViewController: UIViewController {
    
    weak var categoryHeader: CategoryHeader?
    weak var bannerHeader: BannerHeader?
    var presenter: MenuViewPresenterProtocol!
    var collectionView: UICollectionView!
    var cityButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()

        setupCityButton()
        
        view.backgroundColor = .green
        setupNavigationBar()
        setupCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        
    }
    
    func setupNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 60, width: screenSize.width, height: 36))
        navBar.backgroundColor = .background
        navBar.barTintColor = .background
        let navItem = UINavigationItem(title: "")
        let cityItem = UIBarButtonItem(customView: cityButton)
        navItem.leftBarButtonItem = cityItem
        navBar.setItems([navItem], animated: false)
        
        view.addSubview(navBar)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate( [
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func setupCityButton() {

        cityButton.layer.masksToBounds = true
        cityButton.frame = CGRect(x: 0, y: 0, width: 83, height: 20)
        cityButton.backgroundColor = .background
        cityButton.setTitleColor(resources.Color.label, for: .normal)
        
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: 61, height: 20))
        label.text = resources.Strings.Menu.city
        label.textColor = resources.Color.label
        label.backgroundColor = .background
        cityButton.addSubview(label)
        
        let imageArrow = UIImageView(frame: CGRect(x: 69, y: 7, width: 14, height: 8))
        imageArrow.image = UIImage(named: "arrow.png")
        cityButton.addSubview(imageArrow)
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        
        view.addSubview(collectionView)
        view.backgroundColor = .background
    
        collectionView.backgroundColor = .background
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        NSLayoutConstraint.activate( [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        collectionView.register(menuViewCell.self, forCellWithReuseIdentifier: "menuViewCell")
        collectionView.register(BannerHeader.self, forSupplementaryViewOfKind: BannerHeader.identifier, withReuseIdentifier: BannerHeader.identifier)
        collectionView.register(CategoryHeader.self, forSupplementaryViewOfKind: CategoryHeader.identifier, withReuseIdentifier: CategoryHeader.identifier)

    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                return self.createMenuSection()
            case 1:
                return self.createMenuSection()
            case 2:
                return self.createMenuSection()
            case 3:
                return self.createMenuSection()
            default:
                return nil
            }
        }
        
        let bannerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(194))
        let BannerHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: bannerHeaderSize, elementKind: BannerHeader.identifier, alignment: .top)
        BannerHeader.zIndex = -1
        
        
        let CategoryHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(56))
        let CategoryHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: CategoryHeaderSize, elementKind: CategoryHeader.identifier, alignment: .top)
        CategoryHeader.pinToVisibleBounds = true
        
        let configLayout = UICollectionViewCompositionalLayoutConfiguration()
        configLayout.boundarySupplementaryItems = [BannerHeader, CategoryHeader]
        layout.configuration = configLayout
        
        return layout
    }
    
    func createLayoutSection(group: NSCollectionLayoutGroup, behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior, interGroupSpacing: CGFloat, supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem]) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        return section
    }
    
    func createMenuSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(172)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(172)), subitems: [item])
        group.interItemSpacing = .fixed(0)
        let section = createLayoutSection(group: group,
                                          behavior: .none,
                                          interGroupSpacing: 1,
                                          supplementaryItems: [])
        section.contentInsets = .init(top: 1, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
}

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let categoryHeader = categoryHeader else { return }
        if indexPath.section == categoryHeader.selectedCategory {
            categoryHeader.canChange = true
        }
        
        if categoryHeader.canChange && indexPath.section != categoryHeader.selectedCategory {
            categoryHeader.moveToCategory(with: indexPath.section)
            categoryHeader.selectedCategory = indexPath.section
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == CategoryHeader.identifier {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CategoryHeader.identifier, for: indexPath) as! CategoryHeader
            header.delegate = self
            self.categoryHeader = header
            return header
        } else {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BannerHeader.identifier, for: indexPath) as! BannerHeader
            self.bannerHeader = header
            return header
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 10
        case 1:
            return 10
        case 2:
            return 10
        case 3:
            return 10
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let pizzaCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuViewCell", for: indexPath) as? menuViewCell else {
                return UICollectionViewCell()
            }
            let pizza = presenter.pizzas?[indexPath.row]
            getData(from: URL(string: pizza?.img ?? "Banner_1")!) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    pizzaCell.dishImage.image = UIImage(data: data)
                }
            }
            pizzaCell.nameLabel.text = pizza?.name
            pizzaCell.descriptionText.text = pizza?.description
            if indexPath.row == 0 {
                pizzaCell.contentView.layer.cornerRadius = 12
                pizzaCell.contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            }
            
            return  pizzaCell
        case 1:
                        guard let comboCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuViewCell", for: indexPath) as? menuViewCell else {
                            return UICollectionViewCell()
                        }
                        return  comboCell
        case 2:
            guard let desertCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuViewCell", for: indexPath) as? menuViewCell else {
                return UICollectionViewCell()
            }
            return  desertCell
        case 3:
            guard let beverageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuViewCell", for: indexPath) as? menuViewCell else {
                return UICollectionViewCell()
            }
            return  beverageCell
        default: return UICollectionViewCell()
        }
    }
}

extension MenuViewController: MenuViewProtocol {
    func success() {
        collectionView.reloadData()
    }
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

extension MenuViewController: CategoryHeaderDelegate {
    
    func moveToSection(at sectionIndex: Int) {
        guard let categoryHeader = categoryHeader else { return }
        categoryHeader.canChange = false
        collectionView.scrollToItem(at: IndexPath(row: 0, section: sectionIndex), at: .top, animated: true)
    }
}



