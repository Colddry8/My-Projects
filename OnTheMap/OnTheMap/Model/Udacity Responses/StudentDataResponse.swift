//
//  File.swift
//  OnTheMap
//
//  Created by Денис Глущенко on 22/5/2566 BE.
//

import Foundation

struct StudentDataResponse: Codable
{
    let firstName: String?
    let lastName: String?
    let key: String?
    
    enum CodingKeys: String, CodingKey
    {
        case firstName = "first_name"
        case lastName = "last_name"
        case key
    }
}
