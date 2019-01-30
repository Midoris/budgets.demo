//
//  HistoryScreenInteractor.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 19.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import Foundation

protocol HistoryScreenInteractorInput: class {
    func handle(command: HistoryScreenInteractorCommand)
}

enum HistoryScreenInteractorCommand {
    case getBudgets(completion: ([Budget]) -> ())
}

class HistoryScreenInteractor: HistoryScreenInteractorInput {
    func handle(command: HistoryScreenInteractorCommand) {
        switch command {
        case.getBudgets(let completion): self.getBudgets(completion: completion)
        }
    }
}

extension HistoryScreenInteractor {
    private func getBudgets(completion: ([Budget]) -> ()) {
        
        BudgetsStorageManager.getBudgets() { completion($0) }
    }
}

