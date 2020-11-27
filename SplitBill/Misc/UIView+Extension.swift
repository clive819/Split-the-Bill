//
//  UIView+Extension.swift
//  SplitBill
//
//  Created by Clive Liu on 11/11/20.
//

import UIKit


extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
}
