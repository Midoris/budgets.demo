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

}

extension BudgetDetailsTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension BudgetDetailsTableView: UITableViewDelegate {
    
}

