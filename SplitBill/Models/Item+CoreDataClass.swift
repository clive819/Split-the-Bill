//
//  Item+CoreDataClass.swift
//  SplitBill
//
//  Created by Clive Liu on 11/23/20.
//
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    
    var itemSelected = false
    
    func amount() -> Float {
        guard let count = owners?.count else { return value }
        return (value * (1 + tax / 100)) / max(1, Float(count))
    }

}
