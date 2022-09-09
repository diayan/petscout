//
//  Animal+CoreData.swift
//  PetScout
//
//  Created by diayan siat on 06/09/2022.
//

import CoreData

extension AnimalEntity {
    
    var age: Age {
        get {
            guard let ageValue = ageValue,
                    let age = Age(rawValue: ageValue) else { return Age.unknown }
            return age
        }
        
        set {
            self.ageValue = newValue.rawValue
        }
    }
    
    var coat: Coat {
        get {
            guard let coatValue = coatValue,
                    let coat = Coat(rawValue: coatValue) else {return Coat.unknown}
            return coat
        }
        
        set {
            self.coatValue = newValue.rawValue
        }
    }
    
    var gender: Gender {
        get {
            guard let genderValue = genderValue,
                    let gender = Gender(rawValue: genderValue) else {return Gender.unknown}
            return gender
        }
        
        set {
            self.genderValue = newValue.rawValue
        }
    }
    
    var size: Size {
        get {
            guard let sizeValue = sizeValue,
                    let size = Size(rawValue: sizeValue) else { return Size.unknown }
            return size
        }
        
        set {
            self.sizeValue = newValue.rawValue
        }
    }
    
    var status: AdoptionStatus {
      get {
        guard let statusValue = statusValue,
          let status = AdoptionStatus(rawValue: statusValue) else { return AdoptionStatus.unknown }
        return status
      }
      set {
        self.statusValue = newValue.rawValue
      }
    }
    
    @objc var breed: String {
        return breeds?.primary ?? breeds?.secondary ?? ""
    }

    var picture: URL? {
      guard let photos = photos, !photos.allObjects.isEmpty else { return nil }
      let photosArray = photos.allObjects as? [PhotoSizesEntity]
      guard let pArray = photosArray, let firstPhoto = pArray.first else { return nil }
      let pic = firstPhoto.medium ?? firstPhoto.full
      return pic
    }
    
    var emailLink: URL? {
      guard let emailAddress = contact?.email else { return nil }
      return URL(string: "mailto:\(emailAddress)")
    }
    
    var address: String {
        guard let address = contact?.address else { return "No address" }
        return [
            address.address1,
            address.address2,
            address.city,
            address.state,
            address.postcode,
            address.country
        ]
        .compactMap{$0}
        .joined(separator: ", ")
    }
    
    @objc var animalSpecies: String {
      return species ?? "None"
    }
}

//extension Animal: UUIDIdentifiable {
//    init(managedObject: AnimalEntity) {
//        self.age = managedObject.age
//        self.coat = managedObject.coat
//        self.description = managedObject.description
//        self.distance = managedObject.distance
//        self.gender = managedObject.gender
//        self.id = managedObject.id
//        self.organizationId = managedObject.organizationId
//        self.publishedAt = managedObject.publishedAt
//        self.size = managedObject.size
//        self.status = managedObject.status
//        self.species = managedObject.species
//        self.tags = []
//        self.type = managedObject.type ?? "No Type"
//        self.url = managedObject.url
//        self.attributes = AnimalAttributes(managedObject: managedObject.attributes)
//        self.colors = APIColors(managedObject: managedObject.colors)
//        self.contact = Contact(managedObject: managedObject.contact)
//        self.environment = AnimalEnvironment(managedObject: managedObject.environment)
//        let pics = managedObject.photos?.allObjects as? [PhotoSizesEntity]
//        self.photos = pics?.map { PhotoSizes(managedObject: $0) } ?? []
//        let videos = managedObject.videos?.allObjects as? [VideoLinkEntity]
//        self.videos = videos?.map { VideoLink(managedObject: $0) } ?? []
//        self.breeds = Breed(managedObject: managedObject.breeds)
//    }
//    
//    private func checkForExistingAnimal(
//        id: Int,
//        context: NSManagedObjectContext
//        = PersistenceController.shared.container.viewContext
//    ) -> Bool {
//        let fetchRequest = AnimalEntity.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id = %d", id)
//        if let result = try? context.fetch(fetchRequest), result.first != nil {
//            return true
//        }
//        return false
//    }
//    
//    mutating func toManagedObject(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
//        guard let id = self.id else { return }
//        guard checkForExistingAnimal(id: id, context: context) == false else { return }
//        let persistedValue = AnimalEntity.init(context: context)
//        persistedValue.timestamp = Date()
//        persistedValue.age = self.age
//        persistedValue.coat = self.coat ?? .short
//        persistedValue.desc = self.description
//        persistedValue.distance = self.distance ?? 0
//        persistedValue.gender = self.gender
//        persistedValue.id = Int64(self.id)
//        persistedValue.name = self.name
//        persistedValue.organizationId = self.organizationId
//        persistedValue.publishedAt = self.publishedAt
//        persistedValue.size = self.size
//        persistedValue.species = self.species
//        persistedValue.type = self.type
//        persistedValue.url = self.url
//        persistedValue.attributes = self.attributes.toManagedObject(context: context)
//        persistedValue.colors = self.colors.toManagedObject(context: context)
//        persistedValue.contact = self.contact.toManagedObject(context: context)
//        persistedValue.environment = self.environment.toManagedObject(context: context)
//        persistedValue.addToPhotos(NSSet(array: self.photos.map { (photo: PhotoSizes) -> PhotoSizesEntity in
//          var mutablePhoto = photo
//          return mutablePhoto.toManagedObject(context: context)
//        }))
//        persistedValue.addToVideos(NSSet(array: self.videos.map { (video: VideoLink) -> VideoLinkEntity in
//          var mutableVideo = video
//          return mutableVideo.toManagedObject(context: context)
//        }))
//        persistedValue.breeds = self.breeds.toManagedObject(context: context)
//    }
//}
