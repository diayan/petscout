//
//  VideoLink+CoreData.swift
//  PetScout
//
//  Created by diayan siat on 09/09/2022.
//

import Foundation

extension VideoLink: CoreDataPersistable {
    typealias ManagedType = VideoLinkEntity
    
    var keyMap: [PartialKeyPath<VideoLink> : String] {
        [
            \.embedded: "embedded",
             \.id: "id"
        ]
    }
}
