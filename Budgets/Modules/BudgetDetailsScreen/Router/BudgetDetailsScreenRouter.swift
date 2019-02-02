//
//  BudgetDetailsScreenRouter.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 02.02.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

protocol BudgetDetailsScreenRouterInput: class {
    var viewController: UIViewController? { get set }
    func presentView(container: UIResponder?)
    func handle(route: BudgetDetailsScreenRoute)
}

enum BudgetDetailsScreenRoute {
    case someScreen
}

class BudgetDetailsScreenRouter {
    weak var viewController: UIViewController?
}

extension BudgetDetailsScreenRouter: BudgetDetailsScreenRouterInput {
    
    func presentView(container: UIResponder?) {
        guard
            let parentView = container as? UIViewController,
            let viewController = self.viewController
            else { return }
        parentView.present(viewController, animated: true, completion: nil)
    }
    
    func handle(route: BudgetDetailsScreenRoute) {
        switch route {
        case .someScreen: self.showSomeScreen()
        }
    }
    
}

extension BudgetDetailsScreenRouter {
    
    fileprivate func showSomeScreen() {
        // Show some screen
    }
    
}

