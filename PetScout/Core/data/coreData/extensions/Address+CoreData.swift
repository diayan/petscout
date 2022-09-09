//
//  Address+CoreData.swift
//  PetScout
//
//  Created by diayan siat on 09/09/2022.
//

import CoreData

extension Address: CoreDataPersistable {
    typealias ManagedType = AdressEntity
    
    var keyMap: [PartialKeyPath<Address> : String] {
        [
            \.address1: "address1",
             \.address2: "address2",
             \.city: "city",
             \.state: "state",
             \.postcode: "postcode",
             \.country: "country",
             \.id: "id"
        ]
    }
    
}
