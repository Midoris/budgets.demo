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
//        let router = FilesScreenBuilder().setupModule()
//        router.presentView(container: window)
        
        let tabBarController = UITabBarController()
        
        let favoritesVC = ViewController()
        favoritesVC.title = "Favorites"
        favoritesVC.view.backgroundColor = UIColor.orange
        let downloadsVC = ViewController()
        downloadsVC.title = "Downloads"
        downloadsVC.view.backgroundColor = UIColor.blue
        let historyVC = ViewController()
        historyVC.title = "History"
        historyVC.view.backgroundColor = UIColor.cyan
        
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        downloadsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        historyVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
        
        let controllers = [favoritesVC, downloadsVC, historyVC]
        
        tabBarController.viewControllers = controllers
        
        tabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
        
        window?.rootViewController = tabBarController
    }
    
}
