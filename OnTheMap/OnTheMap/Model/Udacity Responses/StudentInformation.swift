//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Денис Глущенко on 16/5/2566 BE.
//

import Foundation

// MARK: StudentInformation
struct StudentInformation: Codable, Equatable {
    
    let objectId: String
    let uniquekey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
    let createdAt: String?
    let updatedAt: String?
    let ACL: String?
    
    enum CodingKeys: String, CodingKey {
        case objectId
        case uniquekey
        case firstName
        case lastName
        case mapString
        case mediaURL
        case latitude
        case longitude
        case createdAt
        case updatedAt
        case ACL
    }
}
