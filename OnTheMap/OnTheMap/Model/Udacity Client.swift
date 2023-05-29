//
//  Udacity Client.swift
//  OnTheMap
//
//  Created by Денис Глущенко on 16/5/2566 BE.
//

import Foundation
import UIKit

// MARK: UdacityClient
class UdacityClient {
    // MARK: Auth
    struct Auth {
        static var uniqueKey = ""
        static var firstName = ""
        static var lastName = ""
        static var objectId = ""
    }
    struct userInfo {
        static var firstName = ""
        static var lastName = ""
    }
    
    
    // MARK: Endpoints
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
    
        
        case getStudentInformation
        case postStudentInformation
        case updateStudentLocation
        case login
        case getUserData
        
        var stringValue: String {
            switch self {
            case .getStudentInformation:
                return Endpoints.base + "/StudentLocation?limit=100&order=-updatedAt"
            case .postStudentInformation:
                return Endpoints.base + "/StudentLocation"
            case .updateStudentLocation:
                return Endpoints.base + "/<objectId>"
            case .login:
                return Endpoints.base + "/session"
            case .getUserData:
                return Endpoints.base + "/users/" + Auth.uniqueKey
            }
        }
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func removeChars(_ data: Data, toRemove: Bool) -> Data
    {
        if toRemove
        {
            let range = 5..<data.count
            let newData = data.subdata(in: range)
            return newData
        }
        return data
    }
    
    @discardableResult class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, toRemove: Bool, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask
    {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else
            {
                print("error, session not working")
                DispatchQueue.main.async { completion(nil, error) }
                return
            }
            
            let decoder = JSONDecoder()
            let newData = removeChars(data, toRemove: toRemove)
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: newData)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
                
            } catch
            {
                
                do
                {
                    let errorResponse = try decoder.decode(OnTheMapResponse.self, from: newData)
                    DispatchQueue.main.async { completion(nil, errorResponse) }
                }
                catch
                {
                    DispatchQueue.main.async { completion(nil, error) }
                }
            }
        }
        task.resume()
        return task
    }
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, toRemove: Bool, completion: @escaping (ResponseType?, Error?) -> Void)
    {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else
            {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            let newData = removeChars(data, toRemove: toRemove)
        
            print(String(data: newData, encoding: .utf8)!)
            do
            {
                let responseObject = try decoder.decode(ResponseType.self, from: newData)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch
            {
                
                do
                {
                    let errorResponse = try decoder.decode(OnTheMapResponse.self, from: newData)
                    
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                    
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    class func getStudentUserData(completion: @escaping (Bool, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getUserData.url, responseType: StudentDataResponse.self, toRemove: true) { (response, error) in
            if let response = response
            {
                userInfo.firstName = response.firstName!
               userInfo.lastName = response.lastName!
                completion(true, nil)
            } else
            {
                completion(false, error)
            }
        }
    }
    
    
    // MARK: GetStudentInformation
    class func getStudentInformation(completion: @escaping ([StudentLocation], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getStudentInformation.url, responseType: LocationsResponseModel.self, toRemove: false) { response, error in
            if let response = response
            {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    // MARK: PostStudentInformation
    class func postStudentInformation(mapString: String, mediaURL: String, latitude: Double, longitude: Double, completion: @escaping (Bool, Error?) -> Void) {
        let body = PostLocationRequest(firstName: userInfo.firstName, lastName: userInfo.lastName, mapString: mapString, latitude: latitude, longitude: longitude, mediaURL: mediaURL, uniqueKey: Auth.uniqueKey)
        taskForPOSTRequest(url: UdacityClient.Endpoints.postStudentInformation.url, responseType: PostLocationResponse.self, body: body, toRemove: false) { response, error in
            if let response = response {
                Auth.objectId = response.objectId
                print("student location added")
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    // MARK: Login
    class func login(userName: String, password: String, completion: @escaping (Bool, Error?) -> ()) {
        let body = LoginRequest(udacity: Udacity(username: userName, password: password))
        
        taskForPOSTRequest(url: UdacityClient.Endpoints.login.url, responseType: LoginResponse.self, body: body, toRemove: true) { (response, error) in
            if let response = response
            {
                Auth.uniqueKey = response.account.key
                completion(true, nil)
            } else
            {
                completion(false, error)
            }
        }
    }
    
    // MARK: Logout
    class func logout(completion: @escaping (Bool, Error?) -> Void) {
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false, error)
                }
                return
            }
            let range = 5..<data.count
            let newData = data.subdata(in: range)
            let decoder = JSONDecoder()
            do {
                _ = try decoder.decode(LogoutResponse.self, from: newData)
                DispatchQueue.main.async {
                    completion(true, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(false, error)
                }
            }
        }
               task.resume()
    }
    
    
}
