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
        
        let salaryFund = Fund(
            name: "Salary",
            amount: 3500.0,
            type: .income,
            entries: []
        )
        let apartmentFund = Fund(
            name: "Apartment",
            amount: 900.0,
            type: .recurring,
            entries: []
        )
        let foodFund = Fund(
            name: "Food",
            amount: 300.0,
            type: .normal,
            entries: []
        )
        let stuffFund = Fund(
            name: "Clothes",
            amount: 200.0,
            type: .normal,
            entries: []
        )
        let baliFund = Fund(
            name: "Bali",
            amount: 900.0,
            type: .saving,
            entries: []
        )
        let investmentFund = Fund(
            name: "Investments",
            amount: 1000.0,
            type: .saving,
            entries: []
        )
        let budget = Budget(
            startDate: Date(),
            endDate: Date(),
            month: "Februrary",
            incomeFunds: [salaryFund],
            expensesFunds: [apartmentFund, foodFund, stuffFund, baliFund, investmentFund],
            currencyCode: "EUR"
        )
        
        completion([budget])
    }
}
