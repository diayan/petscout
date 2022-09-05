//
//  AnimalRequestMock.swift
//  PetScoutTests
//
//  Created by diayan siat on 07/06/2022.
//

import Foundation
@testable import PetScout

enum AnimalsRequestMock: RequestProtocol {
    case getAnimals
    
    var path: String {
        guard let path = Bundle.main.path(
            forResource: "AnimalsMock", ofType: "json"
        )
        else { return "" }
        
        return path
    }
        
    var requestType: RequestType {
        .GET
    }
}
