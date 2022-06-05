//
//  AnimalAttributes.swift
//  PetScout
//
//  Created by diayan siat on 05/06/2022.
//

import Foundation

struct AnimalAttributes: Codable {
  var id: Int?
  var spayedNeutered: Bool? = false
  var houseTrained: Bool? = false
  var declawed: Bool? = false
  var specialNeeds: Bool? = false
  var shotsCurrent: Bool? = false
}
