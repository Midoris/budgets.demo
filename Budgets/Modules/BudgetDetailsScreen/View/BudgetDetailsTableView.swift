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
            self.ds = BudgetDetailsTVHelper.getDS(from: _budget)
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

