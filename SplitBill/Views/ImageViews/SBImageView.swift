//
//  SBImageView.swift
//  SplitBill
//
//  Created by Clive Liu on 11/11/20.
//

import UIKit

class SBImageView: UIImageView {

    private let placeholderImage = SFSymbols.person
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
        tintColor = Colors.tintColor
    }

}
