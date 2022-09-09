//
//  PhotoSizes+CoreData.swift
//  PetScout
//
//  Created by diayan siat on 09/09/2022.
//

import Foundation

extension PhotoSizes: CoreDataPersistable {
    typealias ManagedType = PhotoSizesEntity
    
    var keyMap: [PartialKeyPath<PhotoSizes> : String] {
        [
            \.small: "small",
             \.medium: "medium",
             \.large: "large",
             \.full: "full",
             \.id: "id"
        ]
    }
}
