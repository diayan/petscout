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
    
    //tests if the page is 1 before scroll and checks again after more data has been fetched 
    func testUpdatePageOnFetchMoreAnimals() async {
        XCTAssertEqual(viewModel.page, 1, "the view model's page property should be 1 before fetching but it's \(viewModel.page)")
        await viewModel.fetchMoreAnimals()
        XCTAssertEqual(viewModel.page, 2, "the view model's page property should be 2 after fetching, but it's \(viewModel.page)")
    }
}
