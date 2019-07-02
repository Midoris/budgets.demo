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
    case addFundScreen([Fund]?, Budget?)
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
        case .addFundScreen(let funds, let budget): self.openNewFundScreen(with: funds, and: budget)
        }
    }
    
}

extension BudgetDetailsScreenRouter {
    
    fileprivate func openNewFundScreen(with funds: [Fund]?, and budget: Budget?) {
        guard let controller = AddFundViewController.instance else { return }
        controller.preselectedFund = funds?.first
        controller.budget = budget
        self.viewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
}

