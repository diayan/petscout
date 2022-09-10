//
//  CoreDataTests.swift
//  PetScoutTests
//
//  Created by diayan siat on 05/06/2022.
//

import XCTest
@testable import PetScout
import CoreData

class CoreDataTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testToManagedObject() throws {
        let previewContext =  PersistenceController.shared.container.viewContext
        
        let fetchRequest = AnimalEntity.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \AnimalEntity.name, ascending: true)]
        guard let results = try? previewContext.fetch(fetchRequest),
        let first = results.first else { return }
        
        XCTAssert(first.name == "CHARLA", """
    Pet name did not match, was expecting Kiki, got
    \(String(describing: first.name))
"""
        )
        
        XCTAssert(first.type == "Dog", """
                  Pet type did not match, was expecting Cat, got
                  \(String(describing: first.type))
                """
        )
        
        XCTAssert(first.coat.rawValue == "Short", """
     Pet type did not match, was expecting Cat, got
    \(String(describing: first.coat.rawValue))
  """
        )
    }
    
    func testDeleteManagedObject() throws {
        let previewContext = PersistenceController.shared.container.viewContext
        
        let fetchRequest = AnimalEntity.fetchRequest() //fetch animal entity
        
        guard let results = try? previewContext.fetch(fetchRequest), // fetch all animal entries from db
        let first = results.first else { return } //get the first object
        let expectedResult = results.count - 1 //expected count of items after deletion
        previewContext.delete(first) //delete object
        
        //fetch items after deleting an item
        guard let resultAfterDeletion = try? previewContext.fetch(fetchRequest) else { return }
        
        //compare expected number of items after deletion to the actual count after deletion
        XCTAssertEqual(expectedResult, resultAfterDeletion.count, """
    The number of results was expected to be \(expectedResult) after deletion, was \(results.count)
  """
        )
    }
}
