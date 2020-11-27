//
//  PersonCell.swift
//  SplitBill
//
//  Created by Clive Liu on 11/11/20.
//

import UIKit

class PersonCell: UITableViewCell {
    
    static let identifier = "PersonCell"
    
    private let avatarImageView = SBImageView(frame: .zero)
    private let nameLabel = SBTitleLabel(textAlignment: .left, fontSize: 18)
    private let amountLabel = SBBodyLabel(textAlignment: .right)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(person: Person) {
        nameLabel.text = person.name
        amountLabel.text = String(format: "$%.2f", person.amount())
        avatarImageView.image = person.avatarImage
    }

}


extension PersonCell {
    
    private func layoutUI() {
        addSubviews(avatarImageView, nameLabel, amountLabel)
        
        let padding: CGFloat = 20
        let spacing: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: spacing),
            nameLabel.heightAnchor.constraint(equalToConstant: 60),
            nameLabel.widthAnchor.constraint(equalToConstant: 200),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            amountLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: spacing),
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            amountLabel.heightAnchor.constraint(equalToConstant: 60),
            amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
}
