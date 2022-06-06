//
//  DataParser.swift
//  PetScout
//
//  Created by diayan siat on 06/06/2022.
//

import Foundation

protocol DataParserProtocol {
    func parse<T: Decodable>(data: Data) async throws -> T
}

class DataParser: DataParserProtocol {
    private var jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func parse<T>(data: Data) async throws -> T where T : Decodable {
        return try jsonDecoder.decode(T.self, from: data)
    }
}

