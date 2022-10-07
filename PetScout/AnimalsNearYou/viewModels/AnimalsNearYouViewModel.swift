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

//for AnimalsNearYouView to store states and handle request and user interactions
//final classes cannot be overriden because they disallow subclassing
//final is also a compiler optimzer for speeding up build times
//the ObserverableObject protocol allows you to observe & make changes to the UI
//from outside the view
@MainActor //this ensures that all code in this class is executed on the main thread
final class AnimalsNearYouViewModel: ObservableObject {
    //SwiftUI uses @Published to observe changes in an observableObject
    @Published var isLoading: Bool //for tracking view state
    private let animalFetcher: AnimalsFetcher
    
    init(isLoading: Bool = true, animalFetcher: AnimalsFetcher) {
        self.isLoading = isLoading
        self.animalFetcher = animalFetcher
    }
    
    func fetchAnimals() async {
        let animals  = await animalFetcher.fetchAnimals(page: 1)
        for var animal in animals {
            animal.toManagedObject()
        }
        isLoading = false
    }
}
