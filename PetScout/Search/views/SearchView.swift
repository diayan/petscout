//
//  SearchView.swift
//  PetScout
//
//  Created by diayan siat on 05/06/2022.
//

import SwiftUI

struct SearchView: View {
    //@StateObject makes the viewModel an observable object
    @StateObject var viewModel = SearchViewModel (
        animalSearcher: AnimalSearcherService(requestManager: RequestManager()),
        animalStore: AnimalStoreService(
            context: PersistenceController.shared.container.newBackgroundContext()
        )
    )
    
    var filteredAnimals: [AnimalEntity] {
        guard viewModel.shouldFilter else {return []}
        return animals.filter {
            if viewModel.searchText.isEmpty {
                return true
            }
            return $0.name?.contains(viewModel.searchText) ?? false
        }
    }
    
    //fetch data from core data, filtered by timestamp in ascending order
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(
                keyPath: \AnimalEntity.timestamp, ascending: true
            )],
        animation: .default
    )
    private var animals: FetchedResults<AnimalEntity>
    
    var body: some View {
        NavigationView {
            AnimalListView(animals: filteredAnimals)
                .searchable(
                    text: $viewModel.searchText,
                    placement: .navigationBarDrawer(displayMode: .always)
                )
                .onChange(of: viewModel.searchText) { _ in
                    //implement searching the API 
                    viewModel.search()
                }
                .navigationTitle("Find your future pet")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

