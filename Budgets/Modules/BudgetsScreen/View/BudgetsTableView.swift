//
//  BudgetsTableView.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 10.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class BudgetsTableView: UITableView {
    
    weak var presenter: BudgetsScreenPresenterInput? {
        didSet {
            self.dataSource = self
            self.delegate = self
            self.tableFooterView = UIView()
        }
    }
    var budgets: [Budget] = [] {
        didSet {
            self.ds = budgets.map { BudgetCell2ViewModel(budget: $0) }
        }
    }
    
    var ds: [BudgetCell2ViewModel] = [] {
        didSet {
            self.reloadData()
        }
    }

}

extension BudgetsTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let vm = ds[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        let cell: BudgetCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.viewModel = vm
        
        return cell
    }
    
}

extension BudgetsTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selectedBudget = self.budgets[safe: indexPath.row] else { return }
        self.presenter?.handle(event: .budgetSelected(selectedBudget))
        
    }
}



