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
    case budgetDetails(Budget)
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
        case .budgetDetails(let budget): self.showBudgetDetailsScreen(budget: budget)
        }
    }
    
}

extension BudgetsScreenRouter {
    
    fileprivate func showBudgetDetailsScreen(budget: Budget) {
        let budgetDetailsRouter = BudgetDetailsScreenBuilder()
            .setupModule(selecteBudget: budget)
        guard let budgetVC = budgetDetailsRouter.viewController else { return }
        self.viewController?.navigationController?
            .pushViewController(budgetVC, animated: true)
    }
    
}
