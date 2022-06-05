//
//  PhotoSizes.swift
//  PetScout
//
//  Created by diayan siat on 05/06/2022.
//

import Foundation

struct PhotoSizes: Codable {
  var id: Int?
  var small: URL?
  var medium: URL?
  var large: URL?
  var full: URL?
}
