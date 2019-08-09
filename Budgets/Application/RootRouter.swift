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
        budgetsController.title = "Budgets"
        let budgetsIcon = UIImage(named: "baseline_pie_chart_black_24pt")
        budgetsController.tabBarItem = UITabBarItem(title: "Budgets", image: budgetsIcon, selectedImage: budgetsIcon)
        let budgetsNavController = UINavigationController(rootViewController: budgetsController)
        
        let balanceRouter = BalanceScreenBuilder().setupModule()
        let balanceController = balanceRouter.viewController ?? UIViewController()
        balanceController.title = "Balance"
        let balanceIcon = UIImage(named: "baseline_account_balance_wallet_black_24pt")
        balanceController.tabBarItem = UITabBarItem(title: "Balance", image: balanceIcon, selectedImage: balanceIcon)
        
        let historyRouter = HistoryScreenBuilder().setupModule()
        let historyController = historyRouter.viewController ?? UIViewController()
        historyController.title = "History"
        let historyIcon = UIImage(named: "baseline_history_black_24pt")
        historyController.tabBarItem = UITabBarItem(title: "History", image: historyIcon, selectedImage: historyIcon)
        let historyNavController = UINavigationController(rootViewController: historyController)
        
        let controllers = [budgetsNavController, balanceController,  historyNavController]
        
        tabBarController.viewControllers = controllers
        tabBarController.selectedIndex = 1
        
        window?.rootViewController = tabBarController
    }
    
}
