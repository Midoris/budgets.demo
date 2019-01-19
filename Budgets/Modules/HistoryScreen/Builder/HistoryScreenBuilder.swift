//
//  HistoryScreenBuilder.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 19.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

struct HistoryScreenBuilder {
    
    private let storyBoardName = "HistoryScreen"
    
    func setupModule() -> HistoryScreenRouterInput {
        
        guard
            let view = UIStoryboard(name: self.storyBoardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: HistoryScreenViewController.self)) as? HistoryScreenViewController
            else { return HistoryScreenRouter() }
        
        let router: HistoryScreenRouterInput = HistoryScreenRouter()
        let interactor: HistoryScreenInteractorInput = HistoryScreenInteractor()
        let presenter: HistoryScreenPresenterInput = HistoryScreenPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        
        view.presenter = presenter
        router.viewController = view
        
        return router
    }
}
