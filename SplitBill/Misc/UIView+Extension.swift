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
    
    func useAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func drawShadow() {
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.3
    }
    
}
