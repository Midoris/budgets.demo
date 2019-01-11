//
//  BudgetsScreenInteractor.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 09.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import Foundation

protocol BudgetsScreenInteractorInput: class {
    func handle(command: BudgetsScreenInteractorCommand)
}

enum BudgetsScreenInteractorCommand {
    case getBudgets(completion: ([Budget]) -> ())
}

class BudgetsScreenInteractor: BudgetsScreenInteractorInput {
    func handle(command: BudgetsScreenInteractorCommand) {
        switch command {
        case.getBudgets(let completion): self.getBudgets(completion: completion)
        }
    }
}

extension BudgetsScreenInteractor {
    
    private func getBudgets(completion: ([Budget]) -> ()) {
        
        let salaryFund = Fund(
            name: "Salary",
            amount: 3500.0,
            type: .income,
            entries: []
        )
        let foodFund = Fund(
            name: "Food",
            amount: 300.0,
            type: .normal,
            entries: []
        )
        let budget = Budget(
            startDate: Date(),
            endDate: Date(),
            month: "Februrary",
            incomeFunds: [salaryFund],
            expensesFunds: [foodFund],
            currency: "Euro"
        )
        
        completion([budget])
    }
}
