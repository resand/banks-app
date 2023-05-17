//
//  NSManagedObjectContext+Delete.swift
//  CoreDataServices
//
//  Created by William Boles on 01/04/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import Foundation
import CoreData

/**
 An extension that extends `NSManagedObjectContext` to provide convenience functions related to deleting entries/rows/objects in your Core Data Entity.
 
 In order to use this category you will need to create a subclasses of `NSManagedObject` rather than using KVO.
 */
public extension NSManagedObjectContext {
    
    /**
     Deletes entries/rows/objects from core data entity.
     
     - Parameter entityClass: a class value for the entity in core data.
     */
    func deleteEntries(entityClass: NSManagedObject.Type) {
        self.deleteEntries(entityClass: entityClass, predicate: nil)
    }
    
    /**
     Deletes entries/rows/objects from core data entity that matches the predicate passed.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter predicate: a predicate used to limit the entries deleted.
     */
    func deleteEntries(entityClass: NSManagedObject.Type, predicate: NSPredicate?) {
        var managedObjects: [NSManagedObject]
        
        if let predicate = predicate {
            managedObjects = self.retrieveEntries(entityClass: entityClass, predicate: predicate)
        } else {
            managedObjects = self.retrieveEntries(entityClass: entityClass)
        }
        
        for managedObject in managedObjects {
            self.delete(managedObject)
        }
    }
}
