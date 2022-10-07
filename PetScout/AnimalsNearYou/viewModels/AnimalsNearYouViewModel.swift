//
//  AnimalsNearYouViewModel.swift
//  PetScout
//
//  Created by diayan siat on 07/10/2022.
//

import Foundation

protocol AnimalsFetcher {
    func fetchAnimals(page: Int) async -> [Animal]
}

protocol AnimalStore {
    func save(animals: [Animal]) async throws
}

//for AnimalsNearYouView to store states and handle request and user interactions
//final classes cannot be overriden because they disallow subclassing
//final is also a compiler optimzer for speeding up build times
//the ObserverableObject protocol allows you to observe & make changes to the UI
//from outside the view
@MainActor //this ensures that all code in this class is executed on the main thread
final class AnimalsNearYouViewModel: ObservableObject {
    //SwiftUI uses @Published to observe changes in an observableObject
    @Published var isLoading: Bool //for tracking view state
    @Published var hasMoreAnimals = true
    private let animalFetcher: AnimalsFetcher
    private let animalStore: AnimalStore
    private (set) var page = 1
    
    init(isLoading: Bool = true, animalFetcher: AnimalsFetcher, animalStore: AnimalStore) {
        self.isLoading = isLoading
        self.animalFetcher = animalFetcher
        self.animalStore = animalStore
    }
    
    func fetchAnimals() async {
        let animals  = await animalFetcher.fetchAnimals(page: page)
        do {
            try await animalStore.save(animals: animals)
        }catch {
            print("Error storing animals...\(error.localizedDescription)")
        }
        isLoading = false
        hasMoreAnimals = !animals.isEmpty
    }
    
    func fetchMoreAnimals() async {
        page += 1
        await fetchAnimals()
    }
}
