//
//  RootRouter.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 09.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

protocol RootRouterProtocol {
    func presentRootView(in window: UIWindow?)
}

class RootRouter: RootRouterProtocol {
    
    func presentRootView(in window: UIWindow?) {
        
        let tabBarController = UITabBarController()
        
        let budgetsRouter = BudgetsScreenBuilder().setupModule()
        let budgetsController = budgetsRouter.viewController ?? UIViewController()
        budgetsController.title = "Balance"
        budgetsController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.bookmarks, tag: 0)
        let budgetsNavController = UINavigationController(rootViewController: budgetsController)
        
        let balanceRouter = BalanceScreenBuilder().setupModule()
        let balanceController = balanceRouter.viewController ?? UIViewController()
        balanceController.title = "Budgets"
        balanceController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        let balanceNavController = UINavigationController(rootViewController: balanceController)
        
        let historyVC = ViewController()
        historyVC.title = "History"
        historyVC.view.backgroundColor = UIColor.cyan
        
        historyVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
        
        let controllers = [budgetsNavController, balanceNavController,  UINavigationController(rootViewController: historyVC)]
        
        tabBarController.viewControllers = controllers
        
        window?.rootViewController = tabBarController
    }
    
}
