//
//  Bank+CoreDataProperties.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//
//

import Foundation
import CoreData


extension Bank {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bank> {
        return NSFetchRequest<Bank>(entityName: "Bank")
    }

    @NSManaged public var bankName: String?
    @NSManaged public var bankDescription: String?
    @NSManaged public var bankImage: String?

}
