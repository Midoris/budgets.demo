//
//  HistoryScreenBuilder.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 19.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

struct HistoryScreenBuilder {
    
    static let storyBoardName = "HistoryScreen"
    
    func setupModule() -> HistoryScreenRouterInput {
        
        guard
            let view = UIStoryboard(name: HistoryScreenBuilder.storyBoardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: HistoryScreenViewController.self)) as? HistoryScreenViewController
            else { return HistoryScreenRouter() }
        
        guard let pageController = UIStoryboard(name: HistoryScreenBuilder.storyBoardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: HistoryFunsPageViewController.self)) as? HistoryFunsPageViewController
            else { return HistoryScreenRouter() }
        
        let router: HistoryScreenRouterInput = HistoryScreenRouter()
        let interactor: HistoryScreenInteractorInput = HistoryScreenInteractor()
        let presenter: HistoryScreenPresenterInput & HistoryFundsPageVCPresenterIntput = HistoryScreenPresenter(
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
