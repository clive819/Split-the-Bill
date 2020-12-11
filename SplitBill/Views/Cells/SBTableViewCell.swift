//
//  SBTableViewCell.swift
//  SplitBill
//
//  Created by Clive Liu on 11/11/20.
//

import UIKit


class SBTableViewCell: UITableViewCell {
    
    static let identifier = "SBTableViewCell"
    
    enum IndicatorType {
        case bar
        case circle
    }
    
    enum SecondaryTextStyle {
        case none
        case amountOnly
        case includeTax
    }
    
    private let containerView = UIView()
    private let indicatorView = UIImageView()
    private let stackView = UIStackView()
    private let nameLabel = SBTitleLabel(textAlignment: .left, fontSize: 18)
    private let amountLabel = SBBodyLabel(textAlignment: .left)
    
    private var object: SBObject!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.drawShadow()
    }

    func set(object: SBObject, indicatorType: IndicatorType, secondaryTextStyle: SecondaryTextStyle) {
        self.object = object
        
        nameLabel.text = object.identifier
        
        switch secondaryTextStyle {
        case .none:
            amountLabel.text = nil
            amountLabel.removeFromSuperview()
        case .amountOnly:
            amountLabel.text = String(format: "$%.2f", object.amount)
        case .includeTax:
            amountLabel.text = String(format: "%.2f%% | $%.2f", object.toll, object.amount)
        }
        
        switch indicatorType {
        case .bar:
            indicatorView.image = nil
        case .circle:
            indicatorView.image = SFSymbols.circle
        }
        
        configureIndicatorView()
    }
    
    func toggleSelection() {
        if let _ = indicatorView.image {
            object.isSelected = !object.isSelected
        }

        UIView.animate(withDuration: 0.15) {
            self.containerView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            self.configureIndicatorImage()
        } completion: { (_) in
            self.containerView.backgroundColor = Colors.secondaryBackground
        }
    }

}


extension SBTableViewCell {
    
    private func layoutUI() {
        addSubview(containerView)
        
        backgroundColor = Colors.primaryBackground
        selectionStyle = .none
        
        configureContainerView()
        
        let hPadding: CGFloat = 16
        let vPadding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: vPadding),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -vPadding),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: hPadding),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -hPadding)
        ])
    }
    
    private func configureContainerView() {
        containerView.addSubviews(indicatorView, stackView)
        
        containerView.backgroundColor = Colors.secondaryBackground
        containerView.layer.cornerRadius = 15
        containerView.useAutoLayout()
        
        configureStackView()
    }
    
    private func configureIndicatorView() {
        if let _ = indicatorView.image {
            configureImageView()
        }else {
            configureBarView()
        }
        
        indicatorView.layer.masksToBounds = true
        indicatorView.useAutoLayout()
    }
    
    private func configureBarView() {
        indicatorView.backgroundColor = Colors.blue
        indicatorView.layer.cornerRadius = 2
        
        let padding: CGFloat = 16
        let width: CGFloat = 5
        
        NSLayoutConstraint.activate([
            indicatorView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            indicatorView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            indicatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            indicatorView.widthAnchor.constraint(equalToConstant: width),
            stackView.leadingAnchor.constraint(equalTo: indicatorView.trailingAnchor, constant: padding)
        ])
    }
    
    private func configureImageView() {
        indicatorView.backgroundColor = .clear
        indicatorView.layer.cornerRadius = 0
        
        configureIndicatorImage()
        
        let padding: CGFloat = 16
        let size: CGFloat = 24
        
        NSLayoutConstraint.activate([
            indicatorView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            indicatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            indicatorView.widthAnchor.constraint(equalToConstant: size),
            indicatorView.heightAnchor.constraint(equalToConstant: size),
            stackView.leadingAnchor.constraint(equalTo: indicatorView.trailingAnchor, constant: padding)
        ])
    }
    
    private func configureStackView() {
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(amountLabel)
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.useAutoLayout()
        
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
        ])
    }
    
    private func configureIndicatorImage() {
        if let _ = indicatorView.image {
            if object.isSelected {
                indicatorView.image = SFSymbols.markedCircle
            }else {
                indicatorView.image = SFSymbols.circle
            }
        }
    }
    
}
