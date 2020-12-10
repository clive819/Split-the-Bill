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
    }
    
    func hideEmptyStateView() {
        emptyStateView.removeFromSuperview()
    }

}
