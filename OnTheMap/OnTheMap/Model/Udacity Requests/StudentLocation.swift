//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Денис Глущенко on 18/5/2566 BE.
//

import Foundation

// MARK: StudentLocation
struct StudentLocation: Codable {
   
    let objectId: String
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
    let createdAt: String
    let updatedAt: String
    
}
