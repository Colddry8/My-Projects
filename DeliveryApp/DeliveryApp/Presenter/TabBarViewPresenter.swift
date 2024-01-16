//
//  TabBarViewPresenter.swift
//  DeliveryApp
//
//  Created by Денис Глущенко on 14/1/2567 BE.
//

import UIKit

protocol TabBarViewPresenterProtocol: AnyObject {
    init(view: TabBarViewProtocol)
    func buildTabBar()
}

class TabBarViewPresenter {
    
    weak var view: TabBarViewProtocol?
    required init(view: TabBarViewProtocol) {
        self.view = view
        self.buildTabBar()
    }
}

extension TabBarViewPresenter: TabBarViewPresenterProtocol {
    func buildTabBar() {
        let menuView = ModelBuilder.createMenuViewController()
        let contactView = ModelBuilder.createContactViewController()
        let profileView = ModelBuilder.createProfileViewController()
        let cartView = ModelBuilder.createCartViewController()
        
        menuView.tabBarItem =  UITabBarItem(title: resources.getTitle(tab: resources.Tabs.menu),
                                            image: resources.getImage(tab: resources.Tabs.menu ),
                                            tag: resources.Tabs.menu.rawValue)
        contactView.tabBarItem =  UITabBarItem(title: resources.getTitle(tab: resources.Tabs.contacts),
                                            image: resources.getImage(tab: resources.Tabs.contacts ),
                                            tag: resources.Tabs.contacts.rawValue)
        profileView.tabBarItem =  UITabBarItem(title: resources.getTitle(tab: resources.Tabs.profile),
                                            image: resources.getImage(tab: resources.Tabs.profile ),
                                            tag: resources.Tabs.profile.rawValue)
        cartView.tabBarItem =  UITabBarItem(title: resources.getTitle(tab: resources.Tabs.cart),
                                            image: resources.getImage(tab: resources.Tabs.cart ),
                                            tag: resources.Tabs.cart.rawValue)
        
        self.view?.setControllers(controllers: [menuView, contactView, profileView, cartView])
    }
}
