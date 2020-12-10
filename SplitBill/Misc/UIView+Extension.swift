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
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 40
        layer.shadowOffset = CGSize(width: 0, height: 20)
//        layer.shouldRasterize = true
//        layer.rasterizationScale = UIScreen.main.scale
    }
    
}
