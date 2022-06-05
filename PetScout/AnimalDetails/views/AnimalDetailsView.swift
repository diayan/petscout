//
//  AnimalDetailsView.swift
//  PetScout
//
//  Created by diayan siat on 05/06/2022.
//

import SwiftUI

struct AnimalDetailsView: View {
  var body: some View {
    Text("TODO: Animal Details")
  }
}

struct AnimalsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      AnimalDetailsView()
    }
    .previewLayout(.sizeThatFits)
    .previewDisplayName("iPhone SE (2nd generation)")

    NavigationView {
      AnimalDetailsView()
    }
    .previewDevice("iPhone 13 Pro")
    .previewDisplayName("iPhone 13 Pro")
  }
}
