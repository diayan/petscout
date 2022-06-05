//
//  Breed.swift
//  PetScout
//
//  Created by diayan siat on 05/06/2022.
//

import Foundation


struct Breed: Codable {
  var id: Int?
  var primary: String?
  var secondary: String?
  var mixed: Bool?
  var unknown: Bool?
}
