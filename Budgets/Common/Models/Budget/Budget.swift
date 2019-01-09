//
//  Budget.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 08.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import Foundation

struct Budget {
    let startDate: Date
    let endDate: Date
    let month: String
    let incomeFunds: [Fund]
    let expensesFunds: [Fund]
}

struct Fund {
    let name: String
    let amound: Double
    let type: FundType
    let entries: [FundEntry]
    //let imageName: String
}

struct FundEntry {
    let date: Date
    let amound: Double
    let description: String
}

enum FundType: String {
    case income
    case recurring
    case normal
    case saving
}


/*
 Budget
 - startDate
 - endDate
 - monthName
 - income: [Fund]
 - expenses: [Fund]
 
 Fund
 - type: FundType
 - Name
 - Amount
 - Image name
 - entries [FundEnity]
 - Total amount: calculated var from amount + entire.map { $0.amount }.reduce(+)
 
 FundType
 Case income
 case recurring
 Case normal
 Case saving
 
 
 FundEntry
 - date
 - amount
 - description
 
 */
