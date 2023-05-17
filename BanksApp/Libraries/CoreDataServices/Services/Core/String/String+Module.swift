//
//  String+Module.swift
//  CoreDataServices
//
//  Created by William Boles on 11/11/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import Foundation
import CoreData

/**
 An extension that extends `String` to add functions that focus on interacting with Core Data.
 */
public extension String {
    
    /**
     Strips the module from the class string.
     
     - Parameter entityClass: class value for the entity in core data.
     
     - Returns: Stripped `String` instance of entityClass passed in.
     */
    static func stripModule(entityClass: NSManagedObject.Type) -> String? {
        return String(describing: entityClass).components(separatedBy: ".").last
    }
}
