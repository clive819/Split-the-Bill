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
        UITabBar.appearance().tintColor = Colors.tint
        UITabBar.appearance().barTintColor = Colors.primaryBackground
        
        viewControllers = [createPersonVC(), createAddBillVC()]
        
        configureNavigationBar()
    }
    
    private func createPersonVC() -> UINavigationController {
        let peopleVC = PeopleVC()
        peopleVC.title = "People"
        peopleVC.tabBarItem = UITabBarItem(title: "People", image: SFSymbols.person, tag: 0)
        
        let navController = SBNavigationViewController(rootViewController: peopleVC)
        // TODO: - make navbar round
        
        
        return navController
    }
    
    private func createAddBillVC() -> UINavigationController {
        let addBillVC = AddItemsVC()
        addBillVC.title = "Add Items"
        addBillVC.tabBarItem = UITabBarItem(title: "Add Items", image: SFSymbols.addToCart, tag: 1)
        
        let navController = SBNavigationViewController(rootViewController: addBillVC)
        
        return navController
    }
    
    private func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = Colors.primary
        UINavigationBar.appearance().barTintColor = Colors.primaryBackground
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: Colors.primary]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: Colors.primary]
    }

}
