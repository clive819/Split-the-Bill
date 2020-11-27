//
//  Person+CoreDataProperties.swift
//  SplitBill
//
//  Created by Clive Liu on 11/24/20.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var avatar: Data?
    @NSManaged public var name: String
    @NSManaged public var items: Set<Item>

}

// MARK: Generated accessors for items
extension Person {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: Set<Item>)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: Set<Item>)

}

extension Person : Identifiable {

}
