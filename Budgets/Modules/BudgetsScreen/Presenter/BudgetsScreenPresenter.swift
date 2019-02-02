//
//  BudgetsScreenPresenter.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 09.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import Foundation

class BudgetsScreenPresenter {
    weak var view: BudgetsScreenPresenterOutput?
    let interactor: BudgetsScreenInteractorInput
    let router: BudgetsScreenRouterInput
    
    init(
        view: BudgetsScreenPresenterOutput,
        interactor: BudgetsScreenInteractorInput,
        router: BudgetsScreenRouterInput
        ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

protocol BudgetsScreenPresenterInput: class {
    var view: BudgetsScreenPresenterOutput? { get set }
    var interactor: BudgetsScreenInteractorInput { get }
    var router: BudgetsScreenRouterInput { get }
    func handle(event: BudgetsScreenVCEvent)
}

enum BudgetsScreenVCEvent {
    case viewDidLoad
    case budgetSelected(Budget)
}

extension BudgetsScreenPresenter: BudgetsScreenPresenterInput {
    func handle(event: BudgetsScreenVCEvent) {
        switch event {
        case .viewDidLoad:
            self.handleViewDidLoad()
        case .budgetSelected(let budget):
            self.handleBudgetSelected(budget: budget)
        }
    }
}

extension BudgetsScreenPresenter {
    
    fileprivate func handleViewDidLoad() {
        interactor.handle(command: .getBudgets(completion: handleBudgetsFetched))
    }
    
    fileprivate func handleBudgetsFetched(_ budgets: [Budget]) {
        self.view?.handle(command: .updateTable(with: budgets))
    }
    
    private func handleBudgetSelected(budget: Budget) {
        self.router.handle(route: .budgetDetails(budget))
    }
    
}
