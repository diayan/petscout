//
//  CoreDataPersistable.swift
//  PetScout
//
//  Created by diayan siat on 08/09/2022.
//

import CoreData

//MARK: - All code in this file is to transform back and forth between structs and Core Data classes.

//This code ensures that each of the data model objects is identifiable by an Integer id.
protocol UUIDIdentifiable: Identifiable {
    var id: Int? {get set}
}

protocol CoreDataPersistable: UUIDIdentifiable {
    
    //Associated types are placeholders for concrete types that will be passed in
    //when this protocol is adopted. It will let you bind a value type, struct, with
    //a class type, ManagedType, at compile time
    associatedtype ManagedType

     init() //sets up the object's basic state

    //this initializer's body will handle the conversion from class to struct
     init(managedObject: ManagedType?)

    //To set values from the managed object to the struct, you need to map key paths
    //in the struct to keys in the managed object. This array stores that mapping.
     var keyMap: [PartialKeyPath<Self>: String] { get }

    //saves the struct based object to the core data store
     mutating func toManagedObject(
     context: NSManagedObjectContext) -> ManagedType

    //saves the view context to disk
     func save(context: NSManagedObjectContext) throws
}

//default method implementations
extension CoreDataPersistable where ManagedType: NSManagedObject {
    
    init(managedObject: ManagedType?) {
        self.init()
        guard let managedObject = managedObject else { return }
        
        for attribute in managedObject.entity.attributesByName {
            if let keyP = keyMap.first(
                where: { $0.value == attribute.key })?.key {
                let value =
                managedObject.value(forKey: attribute.key)
                storeValue(value, toKeyPath: keyP)
            }
        }
    }
    
    /*This method takes in a value and a KeyPath, specifically, an AnyKeyPath.
    You then use a switch to check for the real form of the AnyKeyPath.
        In this case, the KeyPath is some flavor of WritableKeyPath.
        WritableKeyPath lets you store the value in the struct. Note here that
        you have to specify each basic type that you could potentially handle.
        For example, there’s no handling of Double values here.*/
    private mutating func storeValue(_ value: Any?, toKeyPath partial: AnyKeyPath) {
        switch partial {
        case let keyPath as WritableKeyPath<Self, URL?>:
            self[keyPath: keyPath] = value as? URL
        case let keyPath as WritableKeyPath<Self, Int?>:
            self[keyPath: keyPath] = value as? Int
        case let keyPath as WritableKeyPath<Self, String?>:
            self[keyPath: keyPath] = value as? String
        case let keyPath as WritableKeyPath<Self, Bool?>:
            self[keyPath: keyPath] = value as? Bool
        default:
            return
        }
    }
    
    //MARK: - to convert the struct objects to Core Data managed objects
    /*toManagedObject(context:) is mutating because the id gets saved back in
    the struct when creating the managed object. This lets you check for
    existing entries in the database.*/
    mutating func toManagedObject(
        context: NSManagedObjectContext
        = PersistenceController.shared.container.viewContext
    ) -> ManagedType {
        let persistedValue: ManagedType
        
        //check to see if struct has a non-nil id value
        if let id = self.id {
            let fetchRequest = ManagedType.fetchRequest()
            //set predicate for fetch request
            fetchRequest.predicate = NSPredicate(
            format: "id = %@", id as CVarArg)
            
            //if id is available, fetch the entry from the database
            if let results = try? context.fetch(fetchRequest),
               let firstResult = results.first as? ManagedType {
                //if successful store the value in persistedValue
                persistedValue = firstResult
            }else {
                //if not make a new object and set it to persistedValue
                persistedValue = ManagedType.init(context: context)
                self.id = persistedValue.value(forKey: "id") as? Int
            }
        }else {
            //if the struct's id is nil, the initializer makes a new object
            //and sets the struct’s id to the managed object’s id.
            persistedValue = ManagedType.init(context: context)
            self.id = persistedValue.value(forKey: "id") as? Int
        }
        return setValuesFromMirror(persistedValue: persistedValue)
    }
    
    /*The Mirror API performs some introspection on the struct. The goal here
     is to map the values at the struct’s keyPaths to those in the managed object.
     Unfortunately, there isn’t a straightforward way to get a hold of the
     values at the key paths, so one has to resort to using Mirror to look inside*/
    //this code uses Mirror to help assign values to the managed object:
    private func setValuesFromMirror(persistedValue: ManagedType) -> ManagedType {
        let mirror = Mirror(reflecting: self) //create a mirror of current struct
        //loop over the each of (label, value) pairings in mirror's children property
        for case let (label?, value) in mirror.children {
            //make a mirror object for the current value
            let value2 = Mirror(reflecting: value)
            //make sure the value is not optional and the value's children is not empty
            if value2.displayStyle != .optional || !value2.children.isEmpty {
                //set the (label, value) pair on the managed object via its setValue(_:, forKey:).
                persistedValue.setValue(value, forKey: label)
            }
        }
        return persistedValue
    }

    /*This method saves the managed object context to disk.
     You implement it here in CoreDataPersistable, so you don’t
     have to duplicate it in every struct that extends CoreDataPersistable.*/
    func save(context: NSManagedObjectContext =
              PersistenceController.shared.container.viewContext) throws {
        try context.save()
    }
}

