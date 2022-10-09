//
//  SearchViewModel.swift
//  PetScout
//
//  Created by diayan siat on 09/10/2022.
//

import Foundation

protocol AnimalSearcher {
    func searchAnimal(
        by text: String,
        age: AnimalSearchAge,
        type: AnimalSearchType
    ) async -> [Animal]
}

final class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    
    var shouldFilter: Bool {
        !searchText.isEmpty
    }
    
    
}
