//
//  NSManagedObjectContext+Count.swift
//  CoreDataServices
//
//  Created by William Boles on 01/04/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import Foundation
import CoreData

/**
 A extension that extends `NSManagedObjectContext` to provide convenience functions related to counting the number of entries/rows/objects in your Core Data Entity.
 
 In order to use this category you will need to create a subclasses of `NSManagedObject` rather than using KVO.
 */
public extension NSManagedObjectContext {
    
    /**
     Retrieves the count of entries.
     
     - Parameter entityClass: a class value for the entity in core data.
     
     - Returns: `NSUInteger` count of entries for this class/entity.
     */
    func retrieveEntriesCount(entityClass: NSManagedObject.Type) -> Int {
        return self.retrieveEntriesCount(entityClass: entityClass, predicate: nil)
    }
    
    /**
     Retrieves the count of entries that match the provided predicate's conditions.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter predicate: a predicate used to limit the entries returned.
     
     - Returns: `NSUInteger` count of entries that match provided predicate.
     */
    func retrieveEntriesCount(entityClass: NSManagedObject.Type, predicate: NSPredicate?) -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityClass: entityClass)
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        
        do {
            let count = try self.count(for: fetchRequest)
            
            return count
        } catch {
            print("Error attempting to retrieve entries count from entity: \(entityClass) with pred: \(String(describing: predicate)). Error: \(error)")
            
            return 0
        }
    }
}
