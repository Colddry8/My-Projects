//
//  PostStudentRequest.swift
//  OnTheMap
//
//  Created by Денис Глущенко on 17/5/2566 BE.
//

import Foundation
import MapKit

// MARK: PostLocationResponse
struct PostLocationRequest: Codable {
    
    let firstName: String
    let lastName: String
    let mapString: String
    let latitude: Double
    let longitude: Double
    let mediaURL: String
    let uniqueKey: String
}
