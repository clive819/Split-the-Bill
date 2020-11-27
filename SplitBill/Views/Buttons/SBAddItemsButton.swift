//
//  SBAddItemsButton.swift
//  SplitBill
//
//  Created by Clive Liu on 11/24/20.
//

import UIKit

class SBBarButton: UIButton {
    
    private var icon: UIImage

    init(icon: UIImage) {
        self.icon = icon
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setImage(icon, for: .normal)
        tintColor = Colors.tintColor
        translatesAutoresizingMaskIntoConstraints = false
        contentVerticalAlignment = .fill
        contentHorizontalAlignment = .fill
    }
    
}
