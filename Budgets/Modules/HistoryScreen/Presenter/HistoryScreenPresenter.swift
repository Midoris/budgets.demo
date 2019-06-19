//
//  HistoryScreenPresenter.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 19.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import Foundation

protocol HistoryScreenPresenterInput: class {
    var view: HistoryScreenViewPresenterOutput? { get set }
    var interactor: HistoryScreenInteractorInput { get }
    var router: HistoryScreenRouterInput { get }
    func handle(event: HistoryScreenVCEvent)
}

enum HistoryScreenVCEvent {
    case viewDidLoad
}

class HistoryScreenPresenter {
    weak var view: HistoryScreenViewPresenterOutput?
    weak var pageVC: HistoryFundsPageVCPresenterOutput?
    let interactor: HistoryScreenInteractorInput
    let router: HistoryScreenRouterInput
    
    init(
        view: HistoryScreenViewPresenterOutput,
        pageVC: HistoryFundsPageVCPresenterOutput,
        interactor: HistoryScreenInteractorInput,
        router: HistoryScreenRouterInput
        ) {
        self.view = view
        self.pageVC = pageVC
        self.interactor = interactor
        self.router = router
    }
}

extension HistoryScreenPresenter: HistoryScreenPresenterInput {
    func handle(event: HistoryScreenVCEvent) {
        switch event {
        case .viewDidLoad: self.handleViewDidLoad()
        }
    }
}

extension HistoryScreenPresenter {

    private func handleViewDidLoad() {
        interactor.handle(command: .getBudgets(completion: handle))
    }
    
    private func handle(budgets: [Budget]) {
        
        guard let lastBadget = budgets.last else { return }
        
        view?.handle(command: .updateUI(lastBadget))
        pageVC?.handle(command: .prepareContetnt(funds: lastBadget.funds, currency: lastBadget.currencyCode, startDate: lastBadget.startDate))
    }

    
}
