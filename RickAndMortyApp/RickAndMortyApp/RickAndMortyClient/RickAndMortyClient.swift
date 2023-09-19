//
//  RickAndMortyClient.swift
//  RickAndMortyApp
//
//  Created by Денис Глущенко on 19/8/2566 BE.
//

import Foundation
 
class RickAndMortyClient {
     let ApiUrl =  URL(string: "https://rickandmortyapi.com/api/character")
    
    enum Endpoints {
        static let base = "https://rickandmortyapi.com/api/"
        case getCharacterInformation
        case getLocationInforamtion
        case getEpisodeInformation
        
        var stringValue: String {
            switch self {
            case .getCharacterInformation:
                return Endpoints.base + "character"
            case .getLocationInforamtion:
                return Endpoints.base + "location"
            case .getEpisodeInformation :
                return Endpoints.base + "episode"
            }
        }
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    @discardableResult class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask
    {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else
            {
                print("error, session not working")
                DispatchQueue.main.async { completion(nil, error) }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
                
            } catch
            {
                    DispatchQueue.main.async { completion(nil, error) }
            }
        }
        task.resume()
        return task
    }
    
    class func getCharactersInformation(completion: @escaping ([RAMCharacterInformation], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getCharacterInformation.url , responseType: RAMResponse.self) { (response, error) in
            if let response = response
            {
                completion(response.results, nil)
            } else
            {
                completion([], error)
            }
        }
    }
    class func getEpisodeInformation(url: URL,completion: @escaping (RAMEpisode, Error?) -> Void) {
        taskForGETRequest(url: url , responseType: RAMEpisode.self) { (response, error) in
            if let response = response
            {
                completion(response, nil)
            } else
            {
                let errorstruct = RAMEpisode(name: "nil", episode: "nil", air_date: "nil")
                completion(errorstruct, error)
            }
        }
    }
    
    class func getOriginInformation(url: URL,completion: @escaping (RAMOrigin, Error?) -> Void) {
        taskForGETRequest(url: url , responseType: RAMOrigin.self) { (response, error) in
            if let response = response
            {
                completion(response, nil)
            } else
            {
                let errorstruct = RAMOrigin(name: "nil", type: "nil")
                completion(errorstruct, error)
            }
        }
    }
    
}
