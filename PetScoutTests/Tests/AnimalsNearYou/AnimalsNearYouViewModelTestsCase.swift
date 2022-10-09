//
//  AnimalsNearYouViewModelTestsCase.swift
//  PetScoutTests
//
//  Created by diayan siat on 08/10/2022.
//

import Foundation
import XCTest
@testable import PetScout

@MainActor
final class AnimalsNearYouViewModelTestCase: XCTestCase {
    let testContext = PersistenceController.preview.container.viewContext
    var viewModel: AnimalsNearYouViewModel!
    
    @MainActor
    override func setUp() {
        super.setUp()
        viewModel = AnimalsNearYouViewModel(
            isLoading: true,
            animalFetcher: AnimalsFetcherMock(),
            animalStore: AnimalStoreService(context: testContext))
    }
    
    func testFetchAnimalsLoadingState() async {
        XCTAssertTrue(viewModel.isLoading, "view should be loading but it's not")
        await viewModel.fetchAnimals()
        XCTAssertFalse(viewModel.isLoading, "view shouldn't be loading but it is loading")
    }
}
