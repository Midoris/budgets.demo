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
    case addFundScreen([Fund], Budget)
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
    
    fileprivate func openNewFundScreen(with funds: [Fund], and budget: Budget) {
        
        let recurringFunds = funds.filter { $0.type == .recurring }
        if funds.count > 0 && recurringFunds.count == funds.count {
            guard let recurringFundsController = RecurringFundsViewController.instance else { return }
            recurringFundsController.funds = recurringFunds
            recurringFundsController.budget = budget
            self.viewController?.navigationController?.pushViewController(recurringFundsController, animated: true)
        } else {
            guard let addFundController = AddFundViewController.instance else { return }
            addFundController.preselectedFund = funds.first
            addFundController.budget = budget
            self.viewController?.navigationController?.pushViewController(addFundController, animated: true)
        }
        
    }
    
}

