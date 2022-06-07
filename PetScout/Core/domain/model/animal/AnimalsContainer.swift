//
//  AnimalsContainer.swift
//  PetScout
//
//  Created by diayan siat on 06/06/2022.
//

import Foundation


struct AnimalsContainer: Decodable {
  let animals: [Animal]
  let pagination: Pagination
}
