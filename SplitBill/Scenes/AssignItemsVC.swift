//
//  AssignItemsVC.swift
//  SplitBill
//
//  Created by Clive Liu on 12/9/20.
//

import UIKit


class AssignItemsVC: SBTableViewController {
    
    private enum Stage {
        case selectItems
        case selectPeople
    }
    
    private let padding: CGFloat = 16
    private let buttonHeight: CGFloat = 44
    private let buttonWidth: CGFloat = 300
    private let button = SBIconButton(icon: SFSymbols.checkMark, tintColor: Colors.red)
    private let items: [Item]
    
    private var people: [Person]!
    private var stage: AssignItemsVC.Stage
    
    private var selectedItems: [Item] {
        items.filter({$0.isSelected})
    }
    private var selectedPeople: [Person] {
        people.filter({$0.isSelected})
    }
    
    

    init(items: [Item]) {
        self.items = items
        self.stage = .selectItems
        super.init(nibName: nil, bundle: nil)
        
        title = "Choose Items"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        button.makeCircle()
        button.drawShadow()
    }
    
    override func configureTableView() {
        super.configureTableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureButton()
    }
    
}


extension AssignItemsVC {
    
    private func configureButton() {
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(moveToNextStage), for: .touchUpInside)
        
        let padding:CGFloat = 30
        let size: CGFloat = 44
        
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            button.widthAnchor.constraint(equalToConstant: size),
            button.heightAnchor.constraint(equalToConstant: size)
        ])
    }
    
    @objc
    private func moveToNextStage() {
        guard !selectedItems.isEmpty else {
            shakeTableView()
            UIDevice.vibrate()
            return
        }
        
        button.removeTarget(self, action: #selector(self.moveToNextStage), for: .touchUpInside)
        button.addTarget(self, action: #selector(self.assign), for: .touchUpInside)
        
        stage = .selectPeople
        
        tableView.transform = CGAffineTransform(translationX: view.frame.width, y: 0)
        
        UIView.animate(withDuration: 0.3) {
            self.title = "Choose People"
            self.tableView.rowHeight = 72
            self.tableView.transform = .identity
            self.tableView.reloadData()
        }
    }
    
    @objc
    private func assign() {
        guard !selectedPeople.isEmpty else {
            shakeTableView()
            UIDevice.vibrate()
            return
        }
        
        let peopleSet = Set(selectedPeople)
        
        for item in selectedItems {
            item.addToOwners(peopleSet)
            item.isSelected = false
        }
        
        for person in selectedPeople {
            person.isSelected = false
        }
        
        navigationController?.popViewController(animated: true)
    }
    
}


extension AssignItemsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if stage == .selectItems {
            return items.count
        }
        
        PersistenceManager.shared.loadPeople { [weak self] (result) in
            switch result {
            case .success(let people):
                self?.people = people
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SBTableViewCell.identifier) as! SBTableViewCell
        
        switch stage {
        case .selectItems:
            cell.set(object: items[indexPath.row], indicatorType: .circle, secondaryTextStyle: .includeTax)
        case .selectPeople:
            cell.set(object: people[indexPath.row], indicatorType: .circle, secondaryTextStyle: .none)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SBTableViewCell
        cell.toggleSelection()
    }
    
}
