//
//  LoginResponse.swift
//  OnTheMap
//
//  Created by Денис Глущенко on 17/5/2566 BE.
//

import Foundation

// MARK: LoginResponse
struct LoginResponse: Codable {
    let account: Account
    let session: Session
}

// MARK: Account
struct Account: Codable {
    let registered: Bool
    let key: String
}

// MARK: Session
struct Session: Codable {
    let id: String
    let expiration: String
}

// MARK: PostLocationResponse
struct PostLocationResponse: Codable {
    
    let createdAt: String
    let objectId: String
    
    enum CodingKeys: String, CodingKey {
        case createdAt
        case objectId
    }
}

extension LoginResponse: LocalizedError
{
    var errorDescription: String?
    {
        return "Invalid username or password"
    }
}



