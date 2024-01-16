//
//  TabBarView.swift
//  DeliveryApp
//
//  Created by Денис Глущенко on 14/1/2567 BE.
//

import UIKit

protocol TabBarViewProtocol: AnyObject {
    func setControllers(controllers: [UIViewController])
}

class TabBarView: UITabBarController {
    
    var presenter: TabBarViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        tabBar.tintColor = resources.Color.primary
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        tabBar.layer.borderColor = resources.Color.separator?.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:resources.Font.SF_UI_Display(with: 13, type: .regular)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
    }
    
    
}

extension TabBarView: TabBarViewProtocol {
    func setControllers(controllers: [UIViewController]) {
        setViewControllers(controllers, animated: true)
    }
}
