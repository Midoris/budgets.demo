//
//  BudgetDetailsTVHelper.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 12.02.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import Foundation

struct BudgetDetailsTVHelper {
    
    static func getDS(from budget: Budget) -> [BudgetDetailsTVCellType] {
        
        let incomeFunds = budget.incomeFunds
        let normalExpenses = budget.expensesFunds.filter { $0.type == .expense }
        let recuringExpenses = budget.expensesFunds.filter { $0.type == .recurring }
        let savingsExpenses = budget.expensesFunds.filter { $0.type == .saving }
        
        var cellTypes: [BudgetDetailsTVCellType] = []
        cellTypes.append(
            BudgetDetailsTVCellType.title(BudgetDetailsSectionTittleCellVM(title: "Income:"))
        )
        incomeFunds.forEach { fund in
            cellTypes.append(
                BudgetDetailsTVCellType.fund(BudgetDetailsFundCellVM(funds: [fund], currencyCode: budget.currencyCode))
            )
        }
        cellTypes.append(BudgetDetailsTVCellType.sectionTotal(BudgetDetailsSectionTotalCellVM(funds: incomeFunds, currencyCode: budget.currencyCode)))
        
        cellTypes.append(BudgetDetailsTVCellType.title(BudgetDetailsSectionTittleCellVM(title: "Expenses:")))
        
        if recuringExpenses.count > 0 {
            cellTypes.append(
                BudgetDetailsTVCellType.fund(BudgetDetailsFundCellVM(funds: recuringExpenses, currencyCode: budget.currencyCode))
            )
        }
        
        normalExpenses.forEach { fund in
            cellTypes.append(
                BudgetDetailsTVCellType.fund(BudgetDetailsFundCellVM(funds: [fund], currencyCode: budget.currencyCode))
            )
        }
        
        cellTypes.append(BudgetDetailsTVCellType.sectionTotal(BudgetDetailsSectionTotalCellVM(funds: recuringExpenses + normalExpenses, currencyCode: budget.currencyCode)))
        
        
        cellTypes.append(BudgetDetailsTVCellType.title(BudgetDetailsSectionTittleCellVM(title: "Savings:")))
        savingsExpenses.forEach { fund in
            cellTypes.append(
                BudgetDetailsTVCellType.fund(BudgetDetailsFundCellVM(funds: [fund], currencyCode: budget.currencyCode))
            )
        }
        
        cellTypes.append(BudgetDetailsTVCellType.sectionTotal(BudgetDetailsSectionTotalCellVM(funds: savingsExpenses, currencyCode: budget.currencyCode)))
        
        
        
        cellTypes.append(BudgetDetailsTVCellType.balance(BudgetDetailsTotalCellVM(budget: budget)))
        
        return cellTypes
    }
}
