//
//  EmptyResultsView.swift
//  PetScout
//
//  Created by diayan siat on 05/06/2022.
//

import SwiftUI


struct EmptyResultsView: View {
  let query: String
  var body: some View {
    VStack {
      Image(systemName: "pawprint.circle.fill")
        .resizable()
        .frame(width: 64, height: 64)
        .padding()
        .foregroundColor(.yellow)
      Text("Sorry, we couldn't find animals for \"\(query)\"")
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
    }
  }
}

struct EmptyResultsView_Previews: PreviewProvider {
  static var previews: some View {
    EmptyResultsView(query: "Kiki")
  }
}
