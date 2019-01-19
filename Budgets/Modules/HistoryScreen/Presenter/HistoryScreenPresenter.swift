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
    case sampleButtonTapped
}

class HistoryScreenPresenter {
    weak var view: HistoryScreenViewPresenterOutput?
    let interactor: HistoryScreenInteractorInput
    let router: HistoryScreenRouterInput
    
    init(
        view: HistoryScreenViewPresenterOutput,
        interactor: HistoryScreenInteractorInput,
        router: HistoryScreenRouterInput
        ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension HistoryScreenPresenter: HistoryScreenPresenterInput {
    func handle(event: HistoryScreenVCEvent) {
        switch event {
        case .viewDidLoad: self.handleViewDidLoad()
        case .sampleButtonTapped: self.handleSampleButtonTapped()
        }
    }
}

extension HistoryScreenPresenter {
    fileprivate func handleViewDidLoad() {
        self.view?.handle(command: .showSampleLabel)
    }
    
    fileprivate func handleSampleButtonTapped() {
        self.interactor.handle(command: .sampleWork)
    }
}
