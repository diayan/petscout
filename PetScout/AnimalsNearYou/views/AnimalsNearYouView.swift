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
          AnimalListView(animals: animals) {
              if !animals.isEmpty && viewModel.hasMoreAnimals {
                  ProgressView("Finding more animals...")
                      .padding()
                      .frame(maxWidth: .infinity)
                      .task {
                          await viewModel.fetchMoreAnimals()
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
        AnimalsNearYouView(
            viewModel: AnimalsNearYouViewModel(
                animalFetcher: AnimalsFetcherMock(),
                animalStore: AnimalStoreService(context: CoreDataHelper.previewContext)
            )
        )
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

