//
//  AnimalEnvironment+CoreData.swift
//  PetScout
//
//  Created by diayan siat on 09/09/2022.
//

import Foundation

extension AnimalEnvironment: CoreDataPersistable {
    typealias ManagedType = AnimalEnvironmentEntity
    
    var keyMap: [PartialKeyPath<AnimalEnvironment> : String] {
        [
            \.children: "children",
             \.dogs: "dogs",
             \.cats: "cats",
             \.id: "id"
        ]
    }
}
