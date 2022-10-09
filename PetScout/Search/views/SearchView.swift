//
//  SearchView.swift
//  PetScout
//
//  Created by diayan siat on 05/06/2022.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
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
            AnimalListView(animals: animals)
                .searchable(
                    text: $searchText,
                    placement: .navigationBarDrawer(displayMode: .always)
                )
                .navigationTitle("Find your future pet")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

