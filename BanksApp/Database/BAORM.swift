//
//  BAORM.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

import CoreData
import Foundation

final class BAORM {
    static let shared = BAORM()

    private static var _backgroundManagedObjectContext: NSManagedObjectContext?

    static func resetAll() {
        CoreDataManager.shared.reset()
    }

    static func getAll<T: NSManagedObject>(entityClass: T.Type, sortDescriptors: [NSSortDescriptor] = []) -> [T] {
        CoreDataManager.shared.mainManagedObjectContext.retrieveEntries(entityClass: entityClass, sortDescriptors: sortDescriptors)
    }

    static func getAll<T: NSManagedObject>(entityClass: T.Type, predicate: NSPredicate, sortDescriptors: [NSSortDescriptor] = []) -> [T] {
        CoreDataManager.shared.mainManagedObjectContext.retrieveEntries(entityClass: entityClass, predicate: predicate, sortDescriptors: sortDescriptors)
    }

    static func get<T: NSManagedObject>(entityClass: T.Type, predicate: NSPredicate, sortDescriptors: [NSSortDescriptor] = []) -> T? {
        CoreDataManager.shared.mainManagedObjectContext.retrieveFirstEntry(entityClass: entityClass, predicate: predicate, sortDescriptors: sortDescriptors)
    }

    static func newObject<T: NSManagedObject>(entityClass: T.Type) -> T {
        let entity = NSEntityDescription.insertNewObject(entityClass: entityClass.self, managedObjectContext: CoreDataManager.shared.mainManagedObjectContext)
        return entity
    }

    static func count(entityClass: (some NSManagedObject).Type) -> Int {
        CoreDataManager.shared.mainManagedObjectContext.retrieveEntriesCount(entityClass: entityClass.self)
    }

    static func saveObject() {
        CoreDataManager.shared.mainManagedObjectContext.performAndWait {
            CoreDataManager.shared.mainManagedObjectContext.saveAndForcePushChangesIfNeeded()
        }
    }
}
