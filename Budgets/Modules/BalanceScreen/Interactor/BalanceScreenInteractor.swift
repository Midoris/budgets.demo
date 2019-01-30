//
//  BalanceScreenInteractor.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 14.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import Foundation

protocol BalanceScreenInteractorInput: class {
    func handle(command: BalanceScreenInteractorCommand)
}

enum BalanceScreenInteractorCommand {
    case getBudgets(completion: ([Budget]) -> ())
}

class BalanceScreenInteractor: BalanceScreenInteractorInput {
    func handle(command: BalanceScreenInteractorCommand) {
        switch command {
        case.getBudgets(let completion): self.getBudgets(completion: completion)
        }
    }
}

extension BalanceScreenInteractor {
    private func getBudgets(completion: ([Budget]) -> ()) {
        
        BudgetsStorageManager.getBudgets() { completion($0) }
    }
}
