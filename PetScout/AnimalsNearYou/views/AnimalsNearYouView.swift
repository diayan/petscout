//
//  AnimalsNearYouView.swift
//  PetScout
//
//  Created by diayan siat on 05/06/2022.
//

import SwiftUI

struct AnimalsNearYouView: View {
    @FetchRequest(
        sortDescriptors:
            [NSSortDescriptor(
                keyPath: \AnimalEntity.timestamp,
                ascending: true)],
        animation: .default
    )
    
    var animals: FetchedResults<AnimalEntity>
    
    @State var isLoading = true
    private let requestManager = RequestManager()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(animals) { animal in
                    AnimalRow(animal: animal)
                }
            }
            .task {
                await fetchAnimals()
            }
            .listStyle(.plain)
            .navigationTitle("Animals near you")
            .overlay {
                if isLoading {
                    ProgressView("Finding Animals near you...")
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
    
    func fetchAnimals() async {
        do {
            let animalsContainer: AnimalsContainer =
            try await requestManager.perform(AnimalsRequest.getAnimalsWith(
                page: 1,
                latitude: nil,
                longitude: nil)
            )
            
            //o convert each animal from the structure to a Core Data object
            for var animal in animalsContainer.animals {
                animal.toManagedObject()
            }
            await stopLoading()
        } catch {
            print("Error fetching animals...\(error)")
        }
    }
    
    @MainActor
    func stopLoading() async {
        isLoading = false
    }
}

struct AnimalsNearYouView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalsNearYouView(isLoading: false)
            .environment(
                \.managedObjectContext,
                 PersistenceController.shared.container.viewContext
            )
        AnimalsNearYouView()
    }
}
