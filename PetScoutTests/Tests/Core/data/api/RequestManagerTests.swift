//
//  RequestManagerTests.swift
//  PetScoutTests
//
//  Created by diayan siat on 07/06/2022.
//

import XCTest
@testable import PetScout


class RequestManagerTests: XCTestCase {
    private var requestManager: RequestManagerProtocol?
    
    /*This code executes first every time a test is run. So there is
     always a fresh instance of RequestManager*/
    override func setUp() {
        super.setUp()
        //get reference to UserDefaults and remove all its content
        guard let userDefaults = UserDefaults(suiteName: #file) else {
            return
        }
        userDefaults.removePersistentDomain(forName: #file)
        
        //initialise request manager with mock objects
        requestManager = RequestManager(
            apiManager: APIManagerMock(),
            accessTokenManager: AccessTokenManager(userDefaults: userDefaults)
        )
    }
    
    
    func testRequestAnimals() async throws {
        guard let container: AnimalsContainer =
                try await requestManager?.perform(
                    AnimalsRequestMock.getAnimals) else {
                        XCTFail("Didn't get data from the request manager")
                        return
                    }
        
        let animals = container.animals
        
        let first = animals.first
        let last = animals.last
        XCTAssertEqual(first?.name, "Kiki")
        XCTAssertEqual(first?.age.rawValue, "Adult")
        XCTAssertEqual(first?.gender.rawValue, "Female")
        XCTAssertEqual(first?.size.rawValue, "Medium")
        XCTAssertEqual(first?.coat?.rawValue, "Short")
        
        XCTAssertEqual(last?.name, "Midnight")
        XCTAssertEqual(last?.age.rawValue, "Adult")
        XCTAssertEqual(last?.gender.rawValue, "Female")
        XCTAssertEqual(last?.size.rawValue, "Large")
        XCTAssertEqual(last?.coat, nil)
    }
    
}
