//
//  Persistence.swift
//  PetScout
//
//  Created by diayan siat on 05/06/2022.
//

import CoreData

struct PersistenceController {
  static let shared = PersistenceController()
    
    //this provide in memory storage for you to persist data in memory
    static var preview: PersistenceController = {
      let result = PersistenceController(inMemory: true)
      let viewContext = result.container.viewContext
      for _ in 0..<10 {
        let newItem = Item(context: viewContext)
        newItem.timestamp = Date()
      }
      do {
        try viewContext.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
      return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
      container = NSPersistentContainer(name: "PetScout")
      if inMemory {
        container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
      }
      container.loadPersistentStores { _, error in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      }
      container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
      container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    //On-Disk Store
    static func save() {
        //get context of core data using the on-disk store
        let context = PersistenceController.shared.container.viewContext
        guard context.hasChanges else { return } // check if there are changes
        do {
            try context.save()
        }catch {
            fatalError("""
                    \(#file), \
                    \(#function), \
                    \(error.localizedDescription)
                  """)
        }
    }
}

