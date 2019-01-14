//
//  BalanceScreenPresenter.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 14.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import Foundation

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
    let interactor: BalanceScreenInteractorInput
    let router: BalanceScreenRouterInput
    
    init(
        view: BalanceScreenViewPresenterOutput,
        interactor: BalanceScreenInteractorInput,
        router: BalanceScreenRouterInput
        ) {
        self.view = view
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
    
    fileprivate func handleViewDidLoad() {

    }
    
}

