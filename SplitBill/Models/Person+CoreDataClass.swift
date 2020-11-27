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
    
    lazy var avatarImage: UIImage = {
        guard let data = self.avatar, let image = UIImage(data: data) else {
            return SFSymbols.person
        }
        return image.withTintColor(Colors.tintColor)
    }()
    
    func amount() -> Float {
        var ans: Float = 0
        for item in items {
            ans += item.amount()
        }
        return ans
    }
    
    func reset() {
        items.removeAll()
        PersistenceManager.shared.saveContext()
    }

}
