//
//  RequestProtocol.swift
//  PetScout
//
//  Created by diayan siat on 05/06/2022.
//

import Foundation

protocol RequestProtocol {
    var path: String { get }
    
    var headers: [String: String] { get }
    //request body
    var params: [String: Any] { get }
    
    //use to attach query params in url
    var urlParams: [String: String?] { get }
    
    //reps if request needs a auth token
    var addAuthorizationToken: Bool { get }

    //specifies type of request eg: GET, POST, DELETE etc
    var requestType: RequestType { get }
}

//default implementation of RequestProtocol
extension RequestProtocol {
    //This is the base URL. Since there is only one, there’s no need to add the protocol definitions.
    var host: String {
        APIConstants.host
    }
    
    //By default, every request has an authorization token
    var addAuthorizationToken: Bool {
        true
    }
    
    /*Some requests don’t require params, urlParams and headers, so they have a default value of an empty dictionary.*/
    var params: [String: Any] {
        [:]
    }
    
    var urlParams: [String: String?] {
        [:]
    }
    
    var headers: [String: String] {
        [:]
    }
    
    
    
    func createUrlRequest(authToken: String) throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        if !urlParams.isEmpty {
            urlComponents.queryItems = urlParams.map {
                URLQueryItem(name: $0, value: $1)
            }
        }
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        
        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        if addAuthorizationToken {
            urlRequest.setValue(authToken, forHTTPHeaderField: "Authorization")
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if !params.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        }
        
        return urlRequest
    }
}
