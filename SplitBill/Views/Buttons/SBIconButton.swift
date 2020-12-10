//
//  SBIconButton.swift
//  SplitBill
//
//  Created by Clive Liu on 11/24/20.
//

import UIKit


class SBIconButton: UIButton {
    
    private var icon: UIImage?
    

    init(icon: UIImage?, tintColor: UIColor) {
        self.icon = icon
        super.init(frame: .zero)
        
        self.tintColor = tintColor
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeCircle() {
        layer.cornerRadius = bounds.width / 2
    }

}


extension SBIconButton {
    
    private func configure() {
        backgroundColor = Colors.primaryBackground
        setImage(icon, for: .normal)
        contentVerticalAlignment = .fill
        contentHorizontalAlignment = .fill
        useAutoLayout()
    }
    
}
