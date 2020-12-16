//
//  SBObject.swift
//  SplitBill
//
//  Created by Clive Liu on 12/8/20.
//

import Foundation


protocol SBObject {
    
    var isSelected: Bool { get set }
    var identifier: String { get }
    var amount: Double { get }
    var toll: Double { get }

}
