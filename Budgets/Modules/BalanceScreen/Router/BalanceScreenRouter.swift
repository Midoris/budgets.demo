//
//  BalanceScreenRouter.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 14.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

protocol BalanceScreenRouterInput: class {
    var viewController: UIViewController? { get set }
    func presentView(container: UIResponder?)
    func handle(route: BalanceScreenRoute)
}

enum BalanceScreenRoute {
    case balanceEntryScreen(AddEntryButtonType)
}

class BalanceScreenRouter {
    weak var viewController: UIViewController?
}

extension BalanceScreenRouter: BalanceScreenRouterInput {
    
    func presentView(container: UIResponder?) {
        guard
            let parentView = container as? UIViewController,
            let viewController = self.viewController
            else { return }
        parentView.present(viewController, animated: true, completion: nil)
    }
    
    func handle(route: BalanceScreenRoute) {
        switch route {
            
        case .balanceEntryScreen(let type):
            guard let controller = BalanceEntryViewController.instance else { return }
            let navController = UINavigationController(rootViewController: controller)
            // TODO: Use type
            self.viewController?.present(navController, animated: true, completion: nil)
        }
    }
    
}

extension BalanceScreenRouter {
    
    
}
