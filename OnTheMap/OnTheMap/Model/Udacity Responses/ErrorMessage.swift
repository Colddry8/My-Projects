//
//  ErrorMessage.swift
//  OnTheMap
//
//  Created by Денис Глущенко on 17/5/2566 BE.
//

import Foundation

struct ErrorMessage: Codable {
    let message: String
    
}

extension ErrorMessage: LocalizedError {
    var errorDescription: String? {
        return message
    }
}
