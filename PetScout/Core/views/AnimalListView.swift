//
//  AnimalListView.swift
//  PetScout
//
//  Created by diayan siat on 09/10/2022.
//

import SwiftUI

struct AnimalListView<Content, Data>: View where
Content: View,
Data: RandomAccessCollection,
Data.Element: AnimalEntity {
    
    let animals: Data
    let footer: Content
    
    init(animals: Data, @ViewBuilder footer: () -> Content) {
        self.animals = animals
        self.footer = footer()
    }
    
    init(animals: Data) where Content == EmptyView {
        self.init(animals: animals) {
            EmptyView()
        }
    }
    
    var body: some View {
        List {
            ForEach(animals) { animal in
                NavigationLink(destination: AnimalDetailsView()) {
                    AnimalRow(animal: animal)
                }
            }
            footer
        }
        .listStyle(.plain)
    }
}

struct AnimalListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AnimalListView(animals: CoreDataHelper.getTestAnimalEntities() ?? [])
        }
        
        NavigationView {
            AnimalListView(animals: []) {
                Text("This is a footer")
            }
        }
    }
}
