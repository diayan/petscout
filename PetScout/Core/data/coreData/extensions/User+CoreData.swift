//
//  User+CoreData.swift
//  PetScout
//
//  Created by diayan siat on 09/09/2022.
//

import Foundation

extension User: CoreDataPersistable {
    typealias ManagedType = UserEntity
    
    var keyMap: [PartialKeyPath<User> : String] {
        [
            \.name: "name",
             \.password: "password",
             \.extra: "extra",
             \.id: "id"
        ]
    }
}
