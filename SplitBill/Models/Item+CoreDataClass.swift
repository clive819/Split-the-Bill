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

    private var selected = false
    
}


extension Item: SBObject {
    
    var isSelected: Bool {
        get {
            return selected
        }
        set {
            selected = newValue
        }
    }
    
    var identifier: String {
        return name
    }
    
    var amount: Double {
        guard let count = owners?.count else { return value }
        return (value * (1 + (tax / 100))) / max(1, Double(count))
    }
    
    var toll: Double {
        return tax
    }

}
