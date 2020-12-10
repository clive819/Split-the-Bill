//
//  Person+CoreDataClass.swift
//  SplitBill
//
//  Created by Clive Liu on 11/23/20.
//
//

import UIKit
import CoreData


@objc(Person)
public class Person: NSManagedObject {
    
    private var selected = false
    
    
    func reset() {
        items.removeAll()
        PersistenceManager.shared.saveContext()
    }

}


extension Person: SBObject {
    
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
    
    var amount: Float {
        var ans: Float = 0
        for item in items {
            ans += item.amount
        }
        return ans
    }
    
    var toll: Float {
        return 0
    }

}
