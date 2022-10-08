//
//  AnimalsNearYouViewModelTestsCase.swift
//  PetScoutTests
//
//  Created by diayan siat on 08/10/2022.
//

import XCTest
@testable import PetScout

@MainActor
final class AnimalsNearYouViewModelTestCase: XCTestCase {
    let testContext = PersistenceController.preview.container.viewContext
    
    var viewModel: AnimalsNearYouViewModel
    
    @MainActor
    override func setUp() {
        super.setUp()
        
        viewModel = AnimalsNearYouViewModel(
            isLoading: true,
            animalFetcher: AnimalsFetcherMock(),
            animalStore: AnimalStoreService(context: testContext))
    }
}
