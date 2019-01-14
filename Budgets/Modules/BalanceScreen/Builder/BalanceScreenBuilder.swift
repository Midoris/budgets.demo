//
//  BalanceScreenBuilder.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 14.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

struct BalanceScreenBuilder {
    
    private let storyBoardName = "BalanceScreen"
    
    func setupModule() -> BalanceScreenRouterInput {
        
        guard
            let view = UIStoryboard(name: self.storyBoardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: BalanceScreenViewController.self)) as? BalanceScreenViewController
            else { return BalanceScreenRouter() }
        
        let router: BalanceScreenRouterInput = BalanceScreenRouter()
        let interactor: BalanceScreenInteractorInput = BalanceScreenInteractor()
        let presenter: BalanceScreenPresenterInput = BalanceScreenPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        
        view.presenter = presenter
        router.viewController = view
        
        return router
    }
}
