//
//  Pagination.swift
//  PetScout
//
//  Created by diayan siat on 05/06/2022.
//

import Foundation

struct Pagination: Codable {
  let countPerPage: Int
  let totalCount: Int
  let currentPage: Int
  let totalPages: Int
}
