//
//  RAMResponse.swift
//  RickAndMortyApp
//
//  Created by Денис Глущенко on 19/8/2566 BE.
//

import Foundation
struct RAMResponse: Codable {
    let results: [RAMCharacterInformation]
}
struct RAMCharacterInformation: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: origins
    let location: locations
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
struct origins: Codable {
    let name: String
    let url: String
}
struct locations: Codable {
    let name: String
    let url: String
}


struct RAMEpisode: Codable {
    let name: String
    let episode: String
    let air_date: String
}

struct RAMOrigin: Codable {
    var name: String
    var type: String
}
