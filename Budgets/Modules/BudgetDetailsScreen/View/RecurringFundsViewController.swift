//
//  RecurringFundsViewController.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 03.07.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class RecurringFundsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var funds: [Fund]?
    var budget: Budget?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        
        self.navigationItem.title = "Recurring Funds"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonTapped))
        

    }
    
    @objc private func addButtonTapped() {
        guard
            let addFundController = AddFundViewController.instance,
            let _budget = self.budget
            else { return }
        
        addFundController.budget = _budget
        addFundController.prepareForReccuring()
        self.navigationController?.pushViewController(addFundController, animated: true)
    }
    
    private func removeFund(fundToRemove: Fund) {
        let filteredFunds = self.funds?.filter { $0 != fundToRemove }
        self.funds = filteredFunds
        // TODO: remove fund
    }

}

extension RecurringFundsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return funds?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let fund = self.funds?[safe: indexPath.row],
            let _budget = self.budget
            else {
            return UITableViewCell()
        }
        
        let vm = BudgetDetailsRecurringFundVM(fund: fund, currencyCode: _budget.currencyCode)
        let cell: BudgetDetailsRecurringFundCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.viewModel = vm
        return cell
        
    }
    
    
}

extension RecurringFundsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let fund = self.funds?[safe: indexPath.row],
            let _budget = self.budget
            else {
                return
        }
        guard let addFundController = AddFundViewController.instance else { return }
        addFundController.preselectedFund = fund
        addFundController.budget = _budget
        self.navigationController?.pushViewController(addFundController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard
            let fundToRemove = self.funds?[safe: indexPath.row]
            else { return }
        if editingStyle == .delete {
            self.removeFund(fundToRemove: fundToRemove)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension RecurringFundsViewController {
    static var instance: RecurringFundsViewController? {
        guard let controller = UIStoryboard(name: "BudgetDetailsScreen", bundle: nil).instantiateViewController(withIdentifier: String(describing: RecurringFundsViewController.self)) as? RecurringFundsViewController else { return nil }
        return controller
    }
}
