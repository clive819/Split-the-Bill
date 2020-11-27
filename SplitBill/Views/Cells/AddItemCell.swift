//
//  AddItemCell.swift
//  SplitBill
//
//  Created by Clive Liu on 11/24/20.
//

import UIKit

class AddItemCell: UITableViewCell {

    static let identifier = "AddItemCell"
    
    private let checkImageView = SBImageView(frame: .zero)
    private let nameLabel = SBTitleLabel(textAlignment: .left, fontSize: 18)
    private let amountLabel = SBBodyLabel(textAlignment: .right)
    private let taxLabel = SBFootnoteLabel(textAlignment: .right)
    
    private var item: Item!
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(item: Item) {
        self.item = item
        
        nameLabel.text = item.name
        amountLabel.text = String(format: "$%.2f", item.value)
        taxLabel.text = String(format: "%.2f%%", item.tax)
        setImage()
    }
    
    func toggeSelection() {
        item.itemSelected = !item.itemSelected
        setImage()
    }

}


extension AddItemCell {
    
    private func layoutUI() {
        addSubviews(checkImageView, nameLabel, amountLabel, taxLabel)
        
        let padding: CGFloat = 20
        let spacing: CGFloat = 12
        let size: CGFloat = 30
        
        NSLayoutConstraint.activate([
            checkImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            checkImageView.heightAnchor.constraint(equalToConstant: size),
            checkImageView.widthAnchor.constraint(equalToConstant: size),
            
            nameLabel.leadingAnchor.constraint(equalTo: checkImageView.trailingAnchor, constant: spacing),
            nameLabel.heightAnchor.constraint(equalToConstant: 60),
            nameLabel.widthAnchor.constraint(equalToConstant: 220),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            amountLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: spacing),
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            amountLabel.heightAnchor.constraint(equalToConstant: 20),
            amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            taxLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor),
            taxLabel.trailingAnchor.constraint(equalTo: amountLabel.trailingAnchor)
        ])
    }
    
    private func setImage() {
        if item.itemSelected {
            checkImageView.image = SFSymbols.check
        }else {
            checkImageView.image = SFSymbols.circle
        }
    }
    
}
