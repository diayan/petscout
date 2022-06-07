//
//  APIManagerMock.swift
//  PetScoutTests
//
//  Created by diayan siat on 07/06/2022.
//

import Foundation
@testable import PetScout


struct APIManagerMock: APIManagerProtocol {
    func perform(_ request: RequestProtocol, authToken: String) async throws -> Data {
        return try Data(contentsOf: URL(fileURLWithPath: request.path), options: .mappedIfSafe)
    }
    
    //return dummy token in the form of string json as Data
    func requestToken() async throws -> Data {
        Data(AccessTokenTestHelper.generateValidToken().utf8)
    }
}
