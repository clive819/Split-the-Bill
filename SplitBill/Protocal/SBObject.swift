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
    var amount: Float { get }
    var toll: Float { get }

}
