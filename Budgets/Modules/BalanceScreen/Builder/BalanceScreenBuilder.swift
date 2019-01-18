//
//  BalanceScreenBuilder.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 14.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

struct BalanceScreenBuilder {
    
    static let storyBoardName = "BalanceScreen"
    
    func setupModule() -> BalanceScreenRouterInput {
        
        guard
            let view = UIStoryboard(name: BalanceScreenBuilder.storyBoardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: BalanceScreenViewController.self)) as? BalanceScreenViewController
            else { return BalanceScreenRouter() }
        
        guard let pageController = UIStoryboard(name: BalanceScreenBuilder.storyBoardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: BalanceFunsPageViewController.self)) as? BalanceFunsPageViewController
            else { return BalanceScreenRouter() }
        
        let router: BalanceScreenRouterInput = BalanceScreenRouter()
        let interactor: BalanceScreenInteractorInput = BalanceScreenInteractor()
        let presenter: BalanceScreenPresenterInput & BalanceFundsPageVCPresenterInput = BalanceScreenPresenter(
            view: view,
            pageVC: pageController,
            interactor: interactor,
            router: router
        )
        
        view.presenter = presenter
        view.pageVC = pageController
        pageController.presenter = presenter
        router.viewController = view
        
        return router
    }
}
