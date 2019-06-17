//
//  BalanceScreenPresenter.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 14.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

protocol BalanceScreenPresenterInput: class {
    var view: BalanceScreenViewPresenterOutput? { get set }
    var interactor: BalanceScreenInteractorInput { get }
    var router: BalanceScreenRouterInput { get }
    func handle(event: BalanceScreenVCEvent)
}

enum BalanceScreenVCEvent {
    case viewDidLoad
}

class BalanceScreenPresenter {
    weak var view: BalanceScreenViewPresenterOutput?
    weak var pageVC: BalanceFundsPageVCPresenterOutput?
    let interactor: BalanceScreenInteractorInput
    let router: BalanceScreenRouterInput
    
    init(
        view: BalanceScreenViewPresenterOutput,
        pageVC: BalanceFundsPageVCPresenterOutput?,
        interactor: BalanceScreenInteractorInput,
        router: BalanceScreenRouterInput
        ) {
        self.view = view
        self.pageVC = pageVC
        self.interactor = interactor
        self.router = router
    }
}

extension BalanceScreenPresenter: BalanceScreenPresenterInput {
    func handle(event: BalanceScreenVCEvent) {
        switch event {
        case .viewDidLoad: self.handleViewDidLoad()
        }
    }
}

extension BalanceScreenPresenter {
    
    private func handleViewDidLoad() {
        interactor.handle(command: .getBudgets(completion: handle))
    }
    
    private func handle(budgets: [Budget]) {
        
        guard let lastBadget = budgets.last else { return }
        
        view?.handle(command: .updateUI(lastBadget))
        let notIncomeFunds = lastBadget.funds.filter { $0.type != .income }
        pageVC?.handle(command: .prepareContetnt(funds: notIncomeFunds, currency: lastBadget.currencyCode))
    }
    
}

