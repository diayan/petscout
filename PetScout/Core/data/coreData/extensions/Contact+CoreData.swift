//
//  Contact+CoreData.swift
//  PetScout
//
//  Created by diayan siat on 09/09/2022.
//

import CoreData

extension Contact: CoreDataPersistable {
    init(managedObject: ContactEntity?) {
        guard let managedObject = managedObject else {return}
        self.id = Int(managedObject.id)
        self.email = managedObject.email
        self.phone = managedObject.phone
        self.address = Address(managedObject: managedObject.address)
    }
    typealias ManagedType = ContactEntity
    
    var keyMap: [PartialKeyPath<Contact> : String] {
        [
            \.email: "email",
             \.phone: "phone",
             \.address: "address",
             \.id: "id"
        ]
    }
    
    mutating func toManagedObject(context: NSManagedObjectContext) -> ManagedType {
        let persistedValue = ContactEntity.init(context: context)
        persistedValue.email = self.email
        persistedValue.phone = self.phone
        
        if var address = self.address {
            persistedValue.address = address.toManagedObject(context: context)
        }
        return persistedValue
    }
}
