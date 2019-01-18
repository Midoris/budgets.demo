//
//  BalanceFundsPageVCPresenter.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 16.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import Foundation

protocol BalanceFundsPageVCPresenterInput: class {
    var pageVC: BalanceFundsPageVCPresenterOutput? { get set }
    func handle(event: BFPageViewEvent)
}

enum BFPageViewEvent {
    case didTransferToNewPage(Int)
}

extension BalanceScreenPresenter: BalanceFundsPageVCPresenterInput {
    func handle(event: BFPageViewEvent) {
        switch event {
        case .didTransferToNewPage(let index):
            view?.handle(command: .updatePageProgress(index))
            HapticFeedbackManager.shared.fireHapticSelection()
        }
    }
}
