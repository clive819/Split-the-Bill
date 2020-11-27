//
//  EmptyStateView.swift
//  SplitBill
//
//  Created by Clive Liu on 11/26/20.
//

import UIKit

class EmptyStateView: UIView {
    
    private let messageLabel = SBTitleLabel(textAlignment: .center, fontSize: 28)
    private let logoImageView = UIImageView()
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        addSubviews(messageLabel, logoImageView)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel

        logoImageView.image = Assets.emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 40

        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
}

