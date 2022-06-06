//
//  RequestManager.swift
//  PetScout
//
//  Created by diayan siat on 06/06/2022.
//

import Foundation


protocol RequestManagerProtocol {
    func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T
}

class RequestManager: RequestManagerProtocol {
    let apiManager: APIManagerProtocol
    let parser: DataParserProtocol
    
    init(apiManager: APIManagerProtocol = APIManager(), parser: DataParserProtocol = DataParser()) {
        self.apiManager = apiManager
        self.parser = parser
    }
    
    func perform<T>(_ request: RequestProtocol) async throws -> T where T : Decodable {
        let data = try await apiManager.perform(request, authToken: "")
        return data
    }
}
