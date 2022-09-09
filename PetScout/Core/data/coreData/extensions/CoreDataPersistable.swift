//
//  CoreDataPersistable.swift
//  PetScout
//
//  Created by diayan siat on 08/09/2022.
//

import CoreData

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
}

