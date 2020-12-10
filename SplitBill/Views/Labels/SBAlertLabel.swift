//
//  SBAlertLabel.swift
//  SplitBill
//
//  Created by Clive Liu on 12/9/20.
//

import UIKit


class SBAlertLabel: UILabel {

    convenience init(message: String) {
        self.init(frame: .zero)
        text = " \(message)"
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
