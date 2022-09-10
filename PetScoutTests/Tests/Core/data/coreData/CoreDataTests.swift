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
}
