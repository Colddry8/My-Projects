//
//  LogoutResponse.swift
//  OnTheMap
//
//  Created by Денис Глущенко on 19/5/2566 BE.
//

import Foundation

// MARK: LogoutResponse
struct LogoutResponse: Codable {
    
    let session: LogoutSession
}

// MARK: LogoutSession
struct LogoutSession: Codable {
    let id: String
    let expiration: String
}
