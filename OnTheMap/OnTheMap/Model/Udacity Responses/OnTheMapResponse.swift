//
//  OnTheMapResponse.swift
//  OnTheMap
//
//  Created by Денис Глущенко on 22/5/2566 BE.
//

import Foundation

class OnTheMapResponse: Codable, Error
{
    
    let status: Int
    let message: String
    
    enum CodingKeys: String, CodingKey
    {
        case status = "status"
        case message = "error"
    }
}

extension OnTheMapResponse: LocalizedError
{
    var errorDescription: String?
    {
        return message
    }
}
