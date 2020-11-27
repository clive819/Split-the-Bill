//
//  Item+CoreDataProperties.swift
//  SplitBill
//
//  Created by Clive Liu on 11/24/20.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String
    @NSManaged public var tax: Float
    @NSManaged public var value: Float
    @NSManaged public var owners: Set<Person>?

}

// MARK: Generated accessors for owners
extension Item {

    @objc(addOwnersObject:)
    @NSManaged public func addToOwners(_ value: Person)

    @objc(removeOwnersObject:)
    @NSManaged public func removeFromOwners(_ value: Person)

    @objc(addOwners:)
    @NSManaged public func addToOwners(_ values: Set<Person>)

    @objc(removeOwners:)
    @NSManaged public func removeFromOwners(_ values: Set<Person>)

}

extension Item : Identifiable {

}
