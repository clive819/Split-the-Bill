//
//  SBTabBarController.swift
//  SplitBill
//
//  Created by Clive Liu on 11/23/20.
//

import UIKit

class SBTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = Colors.tintColor
        viewControllers = [createPersonVC(), createAddBillVC()]
    }
    
    private func createPersonVC() -> UINavigationController {
        let peopleVC = PeopleVC()
        peopleVC.title = "People"
        peopleVC.tabBarItem = UITabBarItem(title: "People", image: SFSymbols.person, tag: 0)
        
        let navController = UINavigationController(rootViewController: peopleVC)
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.tintColor = Colors.tintColor
        
        return navController
    }
    
    private func createAddBillVC() -> UINavigationController {
        let addBillVC = AddItemsVC()
        addBillVC.title = "Add Items"
        addBillVC.tabBarItem = UITabBarItem(title: "Add Items", image: SFSymbols.addBill, tag: 1)
        
        let navController = UINavigationController(rootViewController: addBillVC)
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.tintColor = Colors.tintColor
        
        return navController
    }

}
