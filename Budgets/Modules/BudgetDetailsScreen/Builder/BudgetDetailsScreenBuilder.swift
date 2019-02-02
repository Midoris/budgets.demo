//
//  BudgetDetailsScreenBuilder.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 02.02.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

struct BudgetDetailsScreenBuilder {
    
    private let storyBoardName = "BudgetDetailsScreen"
    
    func setupModule(selecteBudget: Budget) -> BudgetDetailsScreenRouterInput {
        
        guard
            let view = UIStoryboard(name: self.storyBoardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: BudgetDetailsScreenViewController.self)) as? BudgetDetailsScreenViewController
            else { return BudgetDetailsScreenRouter() }
        
        let router: BudgetDetailsScreenRouterInput = BudgetDetailsScreenRouter()
        let interactor: BudgetDetailsScreenInteractorInput = BudgetDetailsScreenInteractor()
        let presenter: BudgetDetailsScreenPresenterInput = BudgetDetailsScreenPresenter(
            view: view,
            interactor: interactor,
            router: router,
            selectedBudget: selecteBudget
        )
        
        view.presenter = presenter
        router.viewController = view
        
        return router
    }
}
