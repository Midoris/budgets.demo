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
    case sampleButtonTapped
}

class BudgetDetailsScreenPresenter {
    weak var view: BudgetDetailsScreenViewPresenterOutput?
    let interactor: BudgetDetailsScreenInteractorInput
    let router: BudgetDetailsScreenRouterInput
    
    init(
        view: BudgetDetailsScreenViewPresenterOutput,
        interactor: BudgetDetailsScreenInteractorInput,
        router: BudgetDetailsScreenRouterInput
        ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension BudgetDetailsScreenPresenter: BudgetDetailsScreenPresenterInput {
    func handle(event: BudgetDetailsScreenVCEvent) {
        switch event {
        case .viewDidLoad: self.handleViewDidLoad()
        case .sampleButtonTapped: self.handleSampleButtonTapped()
        }
    }
}

extension BudgetDetailsScreenPresenter {
    fileprivate func handleViewDidLoad() {
        self.view?.handle(command: .showSampleLabel)
    }
    
    fileprivate func handleSampleButtonTapped() {
        self.interactor.handle(command: .sampleWork)
    }
}
