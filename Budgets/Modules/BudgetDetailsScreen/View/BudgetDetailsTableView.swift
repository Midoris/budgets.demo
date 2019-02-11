//
//  BudgetDetailsTableView.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 02.02.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class BudgetDetailsTableView: UITableView {

    var presenter: BudgetDetailsScreenPresenterInput? {
        didSet {
            self.dataSource = self
            self.delegate = self
            self.tableFooterView = UIView()
        }
    }
    
    var selectedBudget: Budget? {
        didSet {
            
            guard let _budget = selectedBudget else { return }
            
            
            let incomeFunds = _budget.incomeFunds
            let allExpensesFunds = _budget.expensesFunds
            let normalExpenses = _budget.expensesFunds.filter { $0.type == .normal }
            let recuringFunds = _budget.expensesFunds.filter { $0.type == .recurring }
            let savingsFunds = _budget.expensesFunds.filter { $0.type == .saving }
            
            var cellTypes: [BudgetDetailsTVCellType] = []
            cellTypes.append(
                BudgetDetailsTVCellType.title(BudgetDetailsSectionTittleCellVM(title: "Income"))
            )
            incomeFunds.forEach { fund in
                cellTypes.append(
                    BudgetDetailsTVCellType.fund(BudgetDetailsFundCellVM(funds: [fund], currencyCode: _budget.currencyCode))
                )
            }
            cellTypes.append(BudgetDetailsTVCellType.sectionTotal(BudgetDetailsSectionTotalCellVM(funds: incomeFunds, currencyCode: _budget.currencyCode)))
            
            cellTypes.append(BudgetDetailsTVCellType.title(BudgetDetailsSectionTittleCellVM(title: "Expenses")))
            cellTypes.append(
                BudgetDetailsTVCellType.fund(BudgetDetailsFundCellVM(funds: recuringFunds, currencyCode: _budget.currencyCode))
            )
            
            normalExpenses.forEach { fund in
                cellTypes.append(
                    BudgetDetailsTVCellType.fund(BudgetDetailsFundCellVM(funds: [fund], currencyCode: _budget.currencyCode))
                )
            }
            
            cellTypes.append(BudgetDetailsTVCellType.sectionTotal(BudgetDetailsSectionTotalCellVM(funds: recuringFunds + normalExpenses, currencyCode: _budget.currencyCode)))
            
            
            cellTypes.append(BudgetDetailsTVCellType.title(BudgetDetailsSectionTittleCellVM(title: "Savings")))
            savingsFunds.forEach { fund in
                cellTypes.append(
                    BudgetDetailsTVCellType.fund(BudgetDetailsFundCellVM(funds: [fund], currencyCode: _budget.currencyCode))
                )
            }
            
            cellTypes.append(BudgetDetailsTVCellType.sectionTotal(BudgetDetailsSectionTotalCellVM(funds: savingsFunds, currencyCode: _budget.currencyCode)))
            
            
            
            cellTypes.append(BudgetDetailsTVCellType.balance(BudgetDetailsTotalCellVM(budget: _budget)))
            
            
            self.ds = cellTypes
            
        }
    }
    
    var ds: [BudgetDetailsTVCellType] = [] {
        didSet {
            self.reloadData()
        }
    }

}

extension BudgetDetailsTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellType = ds[safe: indexPath.row] else {
            return UITableViewCell()
        }
        return cellType.cell(for: self, at: indexPath)
    }
    
}

extension BudgetDetailsTableView: UITableViewDelegate {
    
}

