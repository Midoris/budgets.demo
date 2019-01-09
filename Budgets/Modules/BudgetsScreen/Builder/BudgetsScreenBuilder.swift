//
//  BudgetsScreenBuilder.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 09.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

struct BudgetsScreenBuilder {
    
    private let storyBoardName = "BudgetsScreen"
    
    func setupModule() -> BudgetsScreenRouterInput {
        
        guard
            let view = UIStoryboard(name: self.storyBoardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: BudgetsScreenViewController.self)) as? BudgetsScreenViewController
            else { return BudgetsScreenRouter() }
        
        let router: BudgetsScreenRouterInput = BudgetsScreenRouter()
        let interactor: BudgetsScreenInteractorInput = BudgetsScreenInteractor()
        let presenter: BudgetsScreenPresenterInput = BudgetsScreenPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        
        view.presenter = presenter
        router.viewController = view
        
        return router
    }
}
