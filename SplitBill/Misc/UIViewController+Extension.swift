//
//  UIViewController+Extension.swift
//  SplitBill
//
//  Created by Clive Liu on 11/26/20.
//

import UIKit


extension UIViewController {
    
    func showEmptyStateView(message: String, in view: UIView) {
        let emptyStateView = EmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        emptyStateView.backgroundColor = .systemBackground
        view.addSubview(emptyStateView)
    }
    
}
