//
//  HistoryFundsPageVCPresenter.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 26.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import Foundation

protocol HistoryFundsPageVCPresenterIntput: class {
    var pageVC: HistoryFundsPageVCPresenterOutput? { get set }
    func handle(event: HFPageViewEvent)
}

enum HFPageViewEvent {
    case didTransferToNewPage(Int)
}

extension HistoryScreenPresenter: HistoryFundsPageVCPresenterIntput {
    func handle(event: HFPageViewEvent) {
        switch event {
        case .didTransferToNewPage(let index):
            view?.handle(command: .updatePageProgress(index))
            HapticFeedbackManager.shared.fireHapticSelection()
        }
    }
}
