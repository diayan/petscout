//
//  FetchAnimalsService.swift
//  PetScout
//
//  Created by diayan siat on 07/10/2022.
//

import Foundation


struct FetchAnimalsService {
    private let requestManager: RequestManagerProtocol
    
    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
}

extension FetchAnimalsService: AnimalsFetcher {
    func fetchAnimals(page: Int) async -> [Animal] {
        let requestData = AnimalsRequest.getAnimalsWith(
            page: 1,
            latitude: nil,
            longitude: nil
        )
        
        do {
            let animalsContainer: AnimalsContainer = try await
            requestManager.perform(requestData)
            return animalsContainer.animals
        }catch {
            print(error.localizedDescription)
            return []
        }
    }
}
