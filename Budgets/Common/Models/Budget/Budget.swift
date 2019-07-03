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
    let funds: [Fund]
    let currencyCode: String
}

struct Fund: Equatable, Hashable {
    let name: String
    let amount: Double
    let type: FundType
    let entries: [FundEntry]
    //let imageName: String
}

extension Fund {
    var balance: Double {
        let allChanges = entries.map { $0.amount }.reduce(0, +)
        return amount + allChanges
    }
}

enum FundType: Equatable, Hashable {
    case income
    case expense
    case recurring
    case saving
    case custom(String)
}

extension FundType {
    var name: String {
        switch self {
        case .income: return "Income"
        case .recurring: return "Recurring"
        case .expense: return "Expense"
        case .saving: return "Saving"
        case .custom(let name): return name
        }
    }
}

struct FundEntry: Equatable, Hashable {
    let date: Date
    let amount: Double
    let description: String
}

enum EntryType: Equatable, Hashable {
    case listing
    case expense
}

func ==(left: FundType, right: FundType) -> Bool {
    switch left {
        
    case .income:
        switch right {
        case .income: return true
        default: return false
        }
    case .expense:
        switch right {
        case .expense: return true
        default: return false
        }
    case .recurring:
        switch right {
        case .recurring: return true
        default: return false
        }
    case .saving:
        switch right {
        case .saving: return true
        default: return false
        }
    case .custom(let leftName):
        switch right {
        case .custom(let rightName): return leftName == rightName
        default: return false
        }
    }
}

func !=(left: FundType, right: FundType) -> Bool {
    switch left {
        
    case .income:
        switch right {
        case .income: return false
        default: return true
        }
    case .expense:
        switch right {
        case .expense: return false
        default: return true
        }
    case .recurring:
        switch right {
        case .recurring: return false
        default: return true
        }
    case .saving:
        switch right {
        case .saving: return false
        default: return true
        }
    case .custom(let leftName):
        switch right {
        case .custom(let rightName): return leftName != rightName
        default: return true
        }
    }
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
