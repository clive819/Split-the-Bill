//
//  SBTableViewController.swift
//  SplitBill
//
//  Created by Clive Liu on 11/25/20.
//

import UIKit


class SBTableViewController: UIViewController {
    
    private lazy var emptyStateView = EmptyStateView(frame: view.bounds)
    
    let tableView = UITableView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    @objc
    func layoutUI() {
        view.backgroundColor = Colors.primaryBackground
        configureTableView()
    }
    
    @objc
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.rowHeight = 96
        tableView.frame = view.bounds
        tableView.isUserInteractionEnabled = true
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.backgroundColor = Colors.primaryBackground
        tableView.register(SBTableViewCell.self, forCellReuseIdentifier: SBTableViewCell.identifier)
    }
    
    func showEmptyStateView() {
        view.addSubview(emptyStateView)
        view.sendSubviewToBack(emptyStateView)
        view.sendSubviewToBack(tableView)
    }
    
    func hideEmptyStateView() {
        emptyStateView.removeFromSuperview()
    }
    
    func shakeTableView() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: tableView.center.x - 10, y: tableView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: tableView.center.x + 10, y: tableView.center.y))

        tableView.layer.add(animation, forKey: "position")
    }
    
    func addOrEditItem(_ item: Item? = nil, _ completion: @escaping ((Item) -> Void)) {
        let alert = UIAlertController(title: "Item Info", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = item?.identifier
            textField.borderStyle = .roundedRect
            textField.keyboardType = .alphabet
            textField.clearButtonMode = .whileEditing
            textField.placeholder = "Please enter item name"
            textField.leftView = SBAlertLabel(message: "Name: ")
            textField.leftViewMode = .always
        }
        
        alert.addTextField { (textField) in
            if let value = item?.value {
                textField.text = "\(value)"
            }
            textField.borderStyle = .roundedRect
            textField.keyboardType = .decimalPad
            textField.clearButtonMode = .whileEditing
            textField.placeholder = "Please enter item value"
            textField.leftView = SBAlertLabel(message: "Value: ")
            textField.leftViewMode = .always
        }
        
        alert.addTextField { (textField) in
            if let tax = item?.tax {
                textField.text = "\(tax)"
            }
            textField.borderStyle = .roundedRect
            textField.placeholder = "Default 0 %"
            textField.keyboardType = .decimalPad
            textField.clearButtonMode = .whileEditing
            textField.leftView = SBAlertLabel(message: "Tax: ")
            textField.leftViewMode = .always
        }
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (_) in
            guard let name = alert.textFields?[0].text,
                  !name.isEmpty,
                  let valueText = alert.textFields?[1].text,
                  !valueText.isEmpty,
                  let value = Double(valueText),
                  let tax = alert.textFields?[2].text
            else {
                UIDevice.vibrate()
                return
            }
            
            let newItem = item ?? Item(context: PersistenceManager.shared.context)
            newItem.name = name
            newItem.value = value
            newItem.tax = Double(tax) ?? 0
            
            completion(newItem)
            self?.tableView.reloadData()
            PersistenceManager.shared.saveContext()
        }))
        
        present(alert, animated: true)
    }

}
