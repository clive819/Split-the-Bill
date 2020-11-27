//
//  SBTableViewController.swift
//  SplitBill
//
//  Created by Clive Liu on 11/25/20.
//

import UIKit

class SBTableViewController: UIViewController {
    
    let tableView = UITableView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }
}


extension SBTableViewController {
    
    @objc
    func layoutUI() {
        view.backgroundColor = .systemBackground
        configureTableView()
    }
    
    @objc
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.rowHeight = 80
        tableView.frame = view.bounds
        tableView.isUserInteractionEnabled = true
        tableView.tableFooterView = UIView(frame: .zero)
    }

}
