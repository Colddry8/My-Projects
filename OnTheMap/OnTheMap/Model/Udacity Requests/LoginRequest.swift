//
//  LoginRequest.swift
//  OnTheMap
//
//  Created by Денис Глущенко on 22/5/2566 BE.
//

import Foundation

struct LoginRequest: Codable
{
    let udacity: Udacity
}

struct Udacity: Codable
{
    let username: String
    let password: String
}
