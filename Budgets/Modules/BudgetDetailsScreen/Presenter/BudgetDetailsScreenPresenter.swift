//
//  BudgetDetailsScreenPresenter.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 02.02.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

protocol BudgetDetailsScreenPresenterInput: class {
    var view: BudgetDetailsScreenViewPresenterOutput? { get set }
    var interactor: BudgetDetailsScreenInteractorInput { get }
    var router: BudgetDetailsScreenRouterInput { get }
    func handle(event: BudgetDetailsScreenVCEvent)
}

enum BudgetDetailsScreenVCEvent {
    case viewDidLoad
    case addNewFundTapped
    case fundCellSelected([Fund])
}

class BudgetDetailsScreenPresenter {
    weak var view: BudgetDetailsScreenViewPresenterOutput?
    let interactor: BudgetDetailsScreenInteractorInput
    let router: BudgetDetailsScreenRouterInput
    var selecteBudget: Budget?
    
    init(
        view: BudgetDetailsScreenViewPresenterOutput,
        interactor: BudgetDetailsScreenInteractorInput,
        router: BudgetDetailsScreenRouterInput,
        selectedBudget: Budget?
        ) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.selecteBudget = selectedBudget
    }
}

extension BudgetDetailsScreenPresenter: BudgetDetailsScreenPresenterInput {
    func handle(event: BudgetDetailsScreenVCEvent) {
        switch event {
        case .viewDidLoad: self.handleViewDidLoad()
        case .addNewFundTapped:
            guard let _selectedBudget = self.selecteBudget else { return }
            self.router.handle(route: BudgetDetailsScreenRoute.addFundScreen([], _selectedBudget))
        case .fundCellSelected(let funds):
            self.hendleFundCellSelected(with: funds)
        }
    }
}

extension BudgetDetailsScreenPresenter {
    
    fileprivate func handleViewDidLoad() {
        // TODO: - handle new budget creation with this screen
        guard let _selectedBudget = self.selecteBudget else { return }
        self.view?.handle(command: .updateUI(_selectedBudget))
    }
    
    fileprivate func hendleFundCellSelected(with funds: [Fund]) {
        guard let _selectedBudget = self.selecteBudget else { return }
        self.router.handle(route: BudgetDetailsScreenRoute.addFundScreen(funds, _selectedBudget))
    }

}
