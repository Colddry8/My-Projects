//
//  ModuleBuilder.swift
//  DeliveryApp
//
//  Created by Денис Глущенко on 13/1/2567 BE.
//

import UIKit

protocol Builder {
    static func createMenuViewController() -> UIViewController
    static func createTabBarController() -> UIViewController
    static func createContactViewController() -> UIViewController
    static func createProfileViewController() -> UIViewController
    static func createCartViewController() -> UIViewController
    
}

class ModelBuilder: Builder {
    
    static func createMenuViewController() -> UIViewController {
        let menuView = MenuViewController()
        let networkService = MenuClient()
        let presenter = MenuPresenter(view: menuView, networkService: networkService)
        menuView.presenter = presenter
        return menuView
    }
    
    static func createTabBarController() -> UIViewController {
        let tabBarView = TabBarView()
        let presenter = TabBarViewPresenter(view: tabBarView)
        tabBarView.presenter = presenter
        return tabBarView
    }
    
    static func createContactViewController() -> UIViewController {
        let contactView = ContactViewController()
        let presenter = ContactPresenter(view: contactView)
        contactView.presenter = presenter
        
        return contactView
    }
    
    static func createProfileViewController() -> UIViewController {
        let profileView = ProfileViewController()
        
        return profileView
    }
    
    static func createCartViewController() -> UIViewController {
        let cartView = CartViewController()
        
        return cartView
    }
}
