//
//  MenuClient.swift
//  DeliveryApp
//
//  Created by Денис Глущенко on 13/1/2567 BE.
//

import Foundation

protocol NetworkServiceProtocol {
    func getPizzas(completion: @escaping (Result<[Pizza]?, Error>) -> Void)
}

class MenuClient: NetworkServiceProtocol {
    
    func getPizzas(completion: @escaping (Result<[Pizza]?, Error>) -> Void) {
        let urlString = "https://pizza-and-desserts.p.rapidapi.com/pizzas"
        let headers = [
            "X-RapidAPI-Key": "f13c143d0dmsh0f1d37a23a6db53p101a99jsn1f3e66adde24",
            "X-RapidAPI-Host": "pizza-and-desserts.p.rapidapi.com"
        ]
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let responseObject = try JSONDecoder().decode([Pizza].self, from: data!)
                completion(.success(responseObject))
            } catch {
                completion(.failure(error))
            }
        } .resume()
    }
    
    
    

}
