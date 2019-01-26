//
//  HistoryFundsEntriesTVPresenter.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 26.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

protocol HistoryFundsPageContentPresenterIntput: class {
    func handle(event: HHFPageContentEvent)
}

enum HHFPageContentEvent {
    
}

extension HistoryScreenPresenter: HistoryFundsPageContentPresenterIntput {
    
    func handle(event: HHFPageContentEvent) {
        
    }
}
