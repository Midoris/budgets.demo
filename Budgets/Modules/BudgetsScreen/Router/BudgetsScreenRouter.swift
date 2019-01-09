//
//  BudgetsScreenRouter.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 09.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit


protocol BudgetsScreenRouterInput: class {
    var viewController: UIViewController? { get set }
    func presentView(container: UIResponder?)
    func handle(route: BudgetsScreenRoute)
}

enum BudgetsScreenRoute {
    case someScreen
}

class BudgetsScreenRouter {
    weak var viewController: UIViewController?
}

extension BudgetsScreenRouter: BudgetsScreenRouterInput {
    
    func presentView(container: UIResponder?) {
        guard
            let parentView = container as? UIViewController,
            let viewController = self.viewController
            else { return }
        parentView.present(viewController, animated: true, completion: nil)
    }
    
    func handle(route: BudgetsScreenRoute) {
        switch route {
        case .someScreen: self.showSomeScreen()
        }
    }
    
}

extension BudgetsScreenRouter {
    
    fileprivate func showSomeScreen() {
        // Show some screen
    }
    
}
