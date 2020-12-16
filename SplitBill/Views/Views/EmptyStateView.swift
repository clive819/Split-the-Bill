//
//  EmptyStateView.swift
//  SplitBill
//
//  Created by Clive Liu on 11/26/20.
//

import UIKit


class EmptyStateView: UIView {
    
    private let logoImageView = UIImageView()
    private let messageLabel = SBTitleLabel(textAlignment: .center, fontSize: 28)
    private let stackView = UIStackView()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


private extension EmptyStateView {
    
    func layoutUI() {
        addSubview(stackView)
        
        backgroundColor = Colors.primaryBackground
        
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(messageLabel)
        
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.useAutoLayout()
        
        logoImageView.image = Assets.emptyStateLogo
        logoImageView.contentMode = .scaleAspectFit
        
        messageLabel.text = "No Items"
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 250),
            stackView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
    
}

