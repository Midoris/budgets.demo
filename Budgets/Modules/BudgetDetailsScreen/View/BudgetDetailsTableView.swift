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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cellType = ds[safe: indexPath.row] else { return }
        switch cellType {
            
        case .fund(let vm):
            presenter?.handle(event: .fundCellSelected(vm.funds))
            
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
         guard let cellType = ds[safe: indexPath.row] else { return .none }
        
        switch cellType {
            
        
        case .fund(let vm):

            let fundTypes = vm.funds.map { $0.type }.unique()
            guard let firstFundType = fundTypes.first else {
                return .none
            }

            switch firstFundType {

            case .recurring:
                return .none
            default:
                return .delete
            }
            
        default: return .none
        
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //TODO implement deletion
        //self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

