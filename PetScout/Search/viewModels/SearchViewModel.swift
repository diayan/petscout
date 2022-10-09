//
//  SearchViewModel.swift
//  PetScout
//
//  Created by diayan siat on 09/10/2022.
//

import Foundation

protocol AnimalSearcher {
    func searchAnimal(
        by text: String,
        age: AnimalSearchAge,
        type: AnimalSearchType
    ) async -> [Animal]
}

final class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    private let animalSearcher: AnimalSearcher
    private let animalStore: AnimalStore //to store results to core data
    
    var shouldFilter: Bool {
        !searchText.isEmpty
    }
    
    //initializer for injecting properties
    init(animalSearcher: AnimalSearcher, animalStore: AnimalStore) {
        self.animalSearcher = animalSearcher
        self.animalStore = animalStore
    }
    
    func search() {
        Task {
            //query the api based on user input
            let animals = await animalSearcher.searchAnimal(
                by: searchText,
                age: .none,
                type: .none
            )
            
            do {
                //save the results to coredata
                try await animalStore.save(animals: animals)
            }catch {
                print("Error storing animals...\(error.localizedDescription)")
            }
        }
    }
}
