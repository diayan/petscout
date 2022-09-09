//
//  AnimalAttributes+CoreData.swift
//  PetScout
//
//  Created by diayan siat on 09/09/2022.
//

import Foundation

extension AnimalAttributes: CoreDataPersistable {
    typealias ManagedType = AnimalAttributesEntity

    var keyMap: [PartialKeyPath<AnimalAttributes> : String] {
        [
            \.spayedNeutered: "spayedNeutered",
             \.houseTrained: "houseTrained",
             \.declawed: "declawed",
             \.specialNeeds: "specialNeeds",
             \.shotsCurrent: "shotsCurrent",
             \.id: "id"
        ]
    }
}
