//
//  Breed+CoreData.swift
//  PetScout
//
//  Created by diayan siat on 09/09/2022.
//

import Foundation

extension Breed: CoreDataPersistable {
    typealias ManagedType = BreedEntity
    //key map connecting keyPaths in Breed with the keys from the managed object
    var keyMap: [PartialKeyPath<Breed> : String]{
        [
            \.primary: "primary",
             \.secondary: "secondary",
             \.mixed: "mixed",
             \.unknown: "unknown",
             \.id: "id"
        ]
    }
}
