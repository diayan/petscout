//
//  SearchView.swift
//  PetScout
//
//  Created by diayan siat on 05/06/2022.
//

import SwiftUI

struct SearchView: View {
    @State var filterPickerIsPresented = false
    //fetch data from core data, filtered by timestamp in ascending order
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(
                keyPath: \AnimalEntity.timestamp, ascending: true
            )],
        animation: .default
    )
    private var animals: FetchedResults<AnimalEntity>
    
    
    //@StateObject makes the viewModel an observable object
    @StateObject var viewModel = SearchViewModel (
        animalSearcher: AnimalSearcherService(requestManager: RequestManager()),
        animalStore: AnimalStoreService(
            context: PersistenceController.shared.container.newBackgroundContext()
        )
    )
    
    private var filterAnimals: FilterAnimals {
        FilterAnimals(
            animals: animals,
            query: viewModel.searchText,
            age: viewModel.ageSelection,
            type: viewModel.typeSelection
        )
    }
    
    var filteredAnimals: [AnimalEntity] {
        guard viewModel.shouldFilter else {return []}
        return filterAnimals()
    }
    
    var body: some View {
        NavigationView {
            AnimalListView(animals: filteredAnimals)
                .searchable(
                    text: $viewModel.searchText,
                    placement: .navigationBarDrawer(displayMode: .always)
                )
                .onChange(of: viewModel.searchText) { _ in
                    //onChange(of:perform:) is a modifier that observes changes to a type that
                    //conforms to Equatable, in this case viewModel.searchText.
                    //implement searching the API 
                    viewModel.search()
                }
                .overlay {
                    if filteredAnimals.isEmpty && !viewModel.searchText.isEmpty {
                        EmptyResultsView(query: viewModel.searchText)
                    }
                }
                .toolbar {
                    ToolbarItem {
                        Button {
                            filterPickerIsPresented.toggle()
                        } label: {
                            Label("Filter", systemImage: "slider.horizontal.3")
                        }
                        .sheet(isPresented: $filterPickerIsPresented) {
                            NavigationView {
                                SearchFilterView(viewModel: viewModel)
                            }
                        }
                    }
                }
                .overlay {
                    if filteredAnimals.isEmpty && viewModel.searchText.isEmpty {
                        SuggestionsGrid(suggestions: AnimalSearchType.suggestions) { suggestion in
                            viewModel.selectTypeSuggestion(suggestion)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    }
                }
                .navigationTitle("Find your future pet")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel(
            animalSearcher: AnimalSearcherMock(),
            animalStore: AnimalStoreService(
                context: PersistenceController.preview.container.viewContext
            )
        ))
            .environment(\.managedObjectContext,
                          PersistenceController.preview.container.viewContext
            )
    }
}

