//
//  ContentView.swift
//  PetScout
//
//  Created by diayan siat on 04/06/2022.
//

import SwiftUI

struct ContentView: View {
    let managedObjectContext =
    PersistenceController.shared.container.viewContext

  var body: some View {
    TabView {
        AnimalsNearYouView(viewModel: AnimalsNearYouViewModel(animalFetcher: FetchAnimalsService(requestManager: RequestManager())))
        .tabItem {
          Label("Near you", systemImage: "location")
        }
        //inject the view context into the SwiftUI Environment.
        .environment(\.managedObjectContext, managedObjectContext)

      SearchView()
        .tabItem {
          Label("Search", systemImage: "magnifyingglass")
        }
        //inject the view context into the SwiftUI Environment.
        .environment(\.managedObjectContext, managedObjectContext)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
