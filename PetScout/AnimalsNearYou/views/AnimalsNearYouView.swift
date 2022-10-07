//
//  AnimalsNearYouView.swift
//  PetScout
//
//  Created by diayan siat on 05/06/2022.
//

import SwiftUI

struct AnimalsNearYouView: View {
    @SectionedFetchRequest<String, AnimalEntity>(
        sectionIdentifier: \AnimalEntity.animalSpecies,
        sortDescriptors:
            [NSSortDescriptor(
                keyPath: \AnimalEntity.timestamp,
                ascending: true)],
        animation: .default
    )
    
    var sectionedAnimals: SectionedFetchResults<String, AnimalEntity>
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sectionedAnimals) { animals in
                    Section(header: Text("\(animals.id)")) {
                        ForEach(animals) { animal in
                            NavigationLink(destination: AnimalDetailsView()) {
                                AnimalRow(animal: animal)
                            }}
                    }
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
