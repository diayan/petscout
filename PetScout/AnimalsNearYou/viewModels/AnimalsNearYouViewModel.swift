//
//  AnimalsNearYouViewModel.swift
//  PetScout
//
//  Created by diayan siat on 07/10/2022.
//

import Foundation

//for AnimalsNearYouView to store states and handle request and user interactions
//final classes cannot be overriden because they disallow subclassing
//final is also a compiler optimzer for speeding up build times
//the ObserverableObject protocol allows you to observe & make changes to the UI
//from outside the view
final class AnimalsNearYouViewModel: ObservableObject {
    //SwiftUI uses @Published to observe changes in an observableObject
    @Published var isLoading: Bool //for tracking view state
    private let requestManager = RequestManager() //to fetch api data
    
    init(isLoading: Bool = false) {
        self.isLoading = isLoading
    }
    
    func fetchAnimals() async {
        do {
            let animalsContainer: AnimalsContainer = try await requestManager.perform(
                AnimalsRequest.getAnimalsWith(
                    page: 1, latitude: nil, longitude: nil
                )
            )
            
            for var animal in animalsContainer.animals {
                animal.toManagedObject()
            }
            isLoading = false
        }catch {
            print("Error fetching animals \(error.localizedDescription)")
        }
    }
}
