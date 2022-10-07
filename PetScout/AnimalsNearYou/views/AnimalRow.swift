//
//  AnimalRow.swift
//  PetScout
//
//  Created by diayan siat on 06/06/2022.
//

import SwiftUI

struct AnimalRow: View {
  let animal: AnimalEntity
    var animalType: String {
        animal.type ?? ""
    }
    
    var animalBreedAndType: String {
        "\(animal.breed) \(animalType)"
    }
    
  var body: some View {
    HStack {
      AsyncImage(url: animal.picture) { image in
        image
          .resizable()
      } placeholder: {
        Image("barnyard")
          .resizable()
          .overlay {
            if animal.picture != nil {
              ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.gray.opacity(0.4))
            }
          }
      }
      .aspectRatio(contentMode: .fit)
      .frame(width: 112, height: 112)
      .cornerRadius(8)

      VStack(alignment: .leading) {
        Text(animal.name ?? "No Name Available")
          .multilineTextAlignment(.center)
          .font(.title3)
          
          Text(animalBreedAndType)
              .font(.callout)
          
          if let description = animal.desc {
              Text(description)
                  .lineLimit(2)
                  .font(.footnote)
          }
          
          HStack {
            Text(animal.age.rawValue)
              .padding(4)
              .background(animal.age.color.opacity(0.2))
              .cornerRadius(8)
              .foregroundColor(animal.age.color)
              .font(.subheadline)
            Text(animal.gender.rawValue)
              .padding(4)
              .background(.pink.opacity(0.2))
              .cornerRadius(8)
              .foregroundColor(.pink)
              .font(.subheadline)
          }
      }
      .lineLimit(1)
    }
  }
}

struct AnimalRow_Previews: PreviewProvider {
  static var previews: some View {
      if let animal = CoreDataHelper.getTestAnimalEntity() {
      AnimalRow(animal: animal)
    }
  }
}
