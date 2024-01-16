//
//  Resources.swift
//  DeliveryApp
//
//  Created by Денис Глущенко on 14/1/2567 BE.
//

import UIKit



enum resources {
    
    
    static let category: [String] = ["Пицца","Комбо","Десерты","Напитки"]
    
    enum Tabs: Int, CaseIterable {
        case menu, contacts, profile, cart
    }
    
    enum Color {
        static let background = UIColor(named: "background")
        static let label = UIColor(named: "label")
        static let textColor = UIColor(named: "textColor")
        static let chevron = UIColor(named: "chevron")
        static let separator = UIColor(named: "separator")
        static let primary = UIColor(named: "primary")
        static let tabbarTint = UIColor(named: "tabbar_tint")
        
        enum categoryColor {
            static let backgroundSelected = UIColor(named: "selected_category")
            static let backgroundUnselected = UIColor.clear
            static let textSelected = UIColor(named: "primary")
            static let textUnselected = UIColor(named: "unselected_category")
            static let borderUnselected = UIColor(named: "unselected_category")
        }
    }
    
  
    static func getImage(tab: Tabs) -> UIImage? {
            switch tab {
                case .menu:
                    return UIImage(named: "menu")
                case .contacts:
                    return UIImage(named: "contact")
                case .cart:
                    return UIImage(named: "cart")
                case .profile:
                    return UIImage(named: "profile")
            }
        }
    
    
    static func getTitle(tab: Tabs) -> String {
        switch tab {
            case .menu:
                return "Меню"
            case .contacts:
                return "Контакты"
            case .cart:
                return "Корзина"
            case .profile:
                return "Профиль"
        }
    }
    
    enum Strings {
        
        enum Menu {
            static let city = "Москва"
        }
        
    }
    enum Font {
        static func SF_UI_Display(with size: CGFloat, type: UIFont.Weight) -> UIFont {
            return .systemFont(ofSize: size, weight: type)
        }
    }
}

