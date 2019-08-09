//
//  BudgetsStorageManager.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 30.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import Foundation

struct BudgetsStorageManager {
    
    static func getBudgets(completion: ([Budget]) -> ()) {
        
        let salaryEntry = FundEntry(date: "20-12-2018".date(for: .littleEndian) ?? Date(),
                                    amount: 3500.0,
                                    description: ""
        )
        let salaryFund = Fund(
            name: "Salary",
            amount: 6400.0,
            type: .income,
            entries: [salaryEntry]
        )
        let apartmentEntry = FundEntry(date: "01-01-2019".date(for: .littleEndian) ?? Date(),
                                       amount: -965.0,
                                       description: ""
        )
        let apartmentFund = Fund(
            name: "Apartment",
            amount: 1000.0,
            type: .recurring,
            entries: [apartmentEntry]
        )
        let electricityFund = Fund(
            name: "Electricity",
            amount: 54.0,
            type: .recurring,
            entries: []
        )
        let foodEntry1 = FundEntry(date: "05-01-2019".date(for: .littleEndian) ?? Date(),
                                  amount: -51.1,
                                  description: ""
        )
        let foodEntry2 = FundEntry(date: "07-01-2019".date(for: .littleEndian) ?? Date(),
                                   amount: -70.1,
                                   description: ""
        )
        let foodFund = Fund(
            name: "Food",
            amount: 300.0,
            type: .expense,
            entries: [foodEntry1, foodEntry2]
        )
        let stuffEntry = FundEntry(date: "09-01-2019".date(for: .littleEndian) ?? Date(),
                                   amount: -15.0,
                                   description: ""
        )
        let stuffFund = Fund(
            name: "Clothes",
            amount: 200.0,
            type: .expense,
            entries: [stuffEntry]
        )
        let travelEntry = FundEntry(date: "20-12-2018".date(for: .littleEndian) ?? Date(),
                                  amount: -1500.0,
                                  description: ""
        )
        let travelFund = Fund(
            name: "Travaling",
            amount: 1500.0,
            type: .saving,
            entries: [travelEntry]
        )
        let investmentEntry = FundEntry(date: "20-12-2018".date(for: .littleEndian) ?? Date(),
                                        amount: -3000,
                                        description: ""
        )
        let investmentFund = Fund(
            name: "Business",
            amount: 3000.0,
            type: .custom("Investments"),
            entries: [investmentEntry]
        )
        
        
        let budget = Budget(
            startDate: "20-12-2018".date(for: .littleEndian) ?? Date(),
            endDate: "28-01-2019".date(for: .littleEndian) ?? Date(),
            month: "Februrary",
            funds: [salaryFund, apartmentFund, electricityFund, foodFund, stuffFund, travelFund, investmentFund],
            currencyCode: "EUR"
        )
        
        completion([budget])
    }
}
