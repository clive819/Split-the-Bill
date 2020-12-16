//
//  PersonItemListVC.swift
//  SplitBill
//
//  Created by Clive Liu on 11/24/20.
//

import UIKit


class PersonItemListVC: SBTableViewController {

    private var items = [Item]()
    
    var person: Person
    
    
    init(person: Person) {
        self.person = person
        super.init(nibName: nil, bundle: nil)
        
        title = person.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureTableView() {
        super.configureTableView()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

}


extension PersonItemListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items = person.items.sorted(by: {$0.value < $1.value})
        
        if items.isEmpty {
            showEmptyStateView()
            
        }else {
            hideEmptyStateView()
        }
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SBTableViewCell.identifier) as! SBTableViewCell
        cell.set(object: items[indexPath.row], indicatorType: .bar, secondaryTextStyle: .includeTax)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SBTableViewCell
        cell.toggleSelection()
        addOrEditItem(items[indexPath.row]) { [weak self] (item) in
            self?.items[indexPath.row] = item
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [createDeleteAction(indexPath: indexPath)])
    }
    
    private func createDeleteAction(indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completion) in
            guard let self = self else {
                completion(false)
                return
            }
            
            let item = self.items[indexPath.row]
            self.items.remove(at: indexPath.row)

            self.person.items.remove(item)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
        }
    }

}
