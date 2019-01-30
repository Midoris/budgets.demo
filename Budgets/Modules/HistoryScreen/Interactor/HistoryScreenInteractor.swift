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
        
        let salaryEntry = FundEntry(date: Date(),
                                    amount: 3500.0,
                                    description: ""
        )
        let salaryFund = Fund(
            name: "Salary",
            amount: 3500.0,
            type: .income,
            entries: [salaryEntry]
        )
        let apartmentEntry = FundEntry(date: Date(),
                                    amount: -965.0,
                                    description: ""
        )
        let apartmentFund = Fund(
            name: "Apartment",
            amount: 1100.0,
            type: .recurring,
            entries: [apartmentEntry]
        )
        let foodEntry = FundEntry(date: Date(),
                                       amount: -51.1,
                                       description: ""
        )
        let foodFund = Fund(
            name: "Food",
            amount: 300.0,
            type: .normal,
            entries: [foodEntry]
        )
        let stuffEntry = FundEntry(date: Date(),
                                  amount: -15.0,
                                  description: ""
        )
        let stuffFund = Fund(
            name: "Clothes",
            amount: 200.0,
            type: .normal,
            entries: [stuffEntry]
        )
        let baliEntry = FundEntry(date: Date(),
                                   amount: -900.0,
                                   description: ""
        )
        let baliFund = Fund(
            name: "Bali",
            amount: 900.0,
            type: .saving,
            entries: [baliEntry]
        )
        let investmentEntry = FundEntry(date: Date(),
                                  amount: -1000,
                                  description: ""
        )
        let investmentFund = Fund(
            name: "Investments",
            amount: 1000.0,
            type: .saving,
            entries: [investmentEntry]
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

