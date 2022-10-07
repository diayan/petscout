//
//  AnimalsFetcherMock.swift
//  PetScout
//
//  Created by diayan siat on 07/10/2022.
//

import Foundation


struct AnimalsFetcherMock: AnimalsFetcher {
    func fetchAnimals(page: Int) async -> [Animal] {
        Animal.mock
    }
}
