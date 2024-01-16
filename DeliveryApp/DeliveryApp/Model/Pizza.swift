//
//  MenuModel.swift
//  DeliveryApp
//
//  Created by Денис Глущенко on 13/1/2567 BE.
//

import Foundation

struct Pizza: Codable {
    var id: Int
    var name: String
    var veg: Bool
    var price: Int
    var description: String
    var quantity: Int
    var img: String
}
