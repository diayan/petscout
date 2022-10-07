//
//  AnimalsNearYouView.swift
//  PetScout
//
//  Created by diayan siat on 05/06/2022.
//

import SwiftUI


struct AnimalsNearYouView: View {
  @FetchRequest(
    sortDescriptors: [
      NSSortDescriptor(keyPath: \AnimalEntity.timestamp, ascending: true)
    ],
    animation: .default
  )
  private var animals: FetchedResults<AnimalEntity>

    @ObservedObject var viewModel: AnimalsNearYouViewModel
    
  var body: some View {
    NavigationView {
      List {
        ForEach(animals) { animal in
          NavigationLink(destination: AnimalDetailsView()) {
            AnimalRow(animal: animal)
          }
        }
      }
      .task {
          await viewModel.fetchAnimals()
      }
      .listStyle(.plain)
      .navigationTitle("Animals near you")
      .overlay {
          if viewModel.isLoading && animals.isEmpty {
          ProgressView("Finding Animals near you...")
        }
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct AnimalsNearYouView_Previews: PreviewProvider {
  static var previews: some View {
    AnimalsNearYouView(viewModel: AnimalsNearYouViewModel())
      .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}

