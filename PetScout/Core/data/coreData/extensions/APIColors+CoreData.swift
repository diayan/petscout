//
//  APIColors.swift
//  PetScout
//
//  Created by diayan siat on 09/09/2022.
//

import Foundation

extension APIColors: CoreDataPersistable {
    typealias ManagedType = APIColorsEntity
    
    var keyMap: [PartialKeyPath<APIColors> : String] {
        [
            \.primary: "primary",
             \.secondary: "secondary",
             \.tertiary: "tertiary",
             \.id: "id"
        ]
    }
}
