//
//  APIManager.swift
//  PetScout
//
//  Created by diayan siat on 05/06/2022.
//

import Foundation

protocol APIManagerProtocol {
    func perform(_ request: RequestProtocol, authToken: String) async throws  -> Data
    
    func requestToken() async throws -> Data
}

class APIManager: APIManagerProtocol {
    private let urlSession: URLSession
    
    /*initialize urlSession with default shared URLSession.shared provides a
     singleton that returns a URLSession.
     For most use cases, like this app, using URLSession.shared is enough.
     But you shouldn’t do things like customizing the cache, cookie storage
     or credential storage when using shared. For that, create a URLSessionConfiguration object.
     */
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func perform(_ request: RequestProtocol, authToken: String = "") async throws -> Data {
        let (data, response) = try await urlSession.data(for: request.createUrlRequest(authToken: authToken))
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200  else {
                  throw NetworkError.invalidServerResponse
              }
        return data
    }
    
    func requestToken() async throws -> Data {
        try await perform(AuthTokenRequest.auth)
    }

}
