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
        let budgetsNavController = UINavigationController(rootViewController: budgetsController)
        
        
        let downloadsVC = ViewController()
        downloadsVC.title = "Downloads"
        downloadsVC.view.backgroundColor = UIColor.blue
        let historyVC = ViewController()
        historyVC.title = "History"
        historyVC.view.backgroundColor = UIColor.cyan
        
        downloadsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        historyVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
        
        let controllers = [budgetsNavController, UINavigationController(rootViewController: downloadsVC), UINavigationController(rootViewController: historyVC)]
        
        tabBarController.viewControllers = controllers
        
        window?.rootViewController = tabBarController
    }
    
}
