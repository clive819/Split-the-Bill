//
//  ItemCell.swift
//  SplitBill
//
//  Created by Clive Liu on 11/24/20.
//

import UIKit

class ItemCell: UITableViewCell {
    
    static let identifier = "ItemCell"
    
    private let nameLabel = SBTitleLabel(textAlignment: .left, fontSize: 18)
    private let amountLabel = SBBodyLabel(textAlignment: .right)
    private let taxLabel = SBFootnoteLabel(textAlignment: .right)
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(item: Item) {
        nameLabel.text = item.name
        amountLabel.text = String(format: "$%.2f", item.value)
        taxLabel.text = String(format: "%.2f%%", item.tax)
    }

}


extension ItemCell {
    
    private func layoutUI() {
        addSubviews(nameLabel, amountLabel, taxLabel)
        
        let padding: CGFloat = 20
        let spacing: CGFloat = 12
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 60),
            nameLabel.widthAnchor.constraint(equalToConstant: 250),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            amountLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: spacing),
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            amountLabel.heightAnchor.constraint(equalToConstant: 20),
            amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            taxLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor),
            taxLabel.trailingAnchor.constraint(equalTo: amountLabel.trailingAnchor)
        ])
    }
    
}
