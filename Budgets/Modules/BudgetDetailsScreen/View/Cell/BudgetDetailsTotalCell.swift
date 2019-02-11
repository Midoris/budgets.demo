//
//  BudgetDetailsTotalCell.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 11.02.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class BudgetDetailsTotalCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var viewModel: BudgetDetailsTotalCellVM? {
        didSet {
            guard let vm = viewModel else { return }
            self.titleLabel.text = vm.title
            self.amountLabel.text = vm.amount
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}

struct BudgetDetailsTotalCellVM {
    let title: String
    let amount: String
}

extension BudgetDetailsTotalCellVM {
    init(budget: Budget) {
        self.title = "Balance:"
        
        let currencySymbol = CurrencyManager
            .getCurrencyFromCode(code: budget.currencyCode)?.symol ?? ""
        let diff = budget.incomeFunds.map { $0.amount }.reduce(0, +) - budget.expensesFunds.map { $0.amount }.reduce(0, +)
        self.amount = "\(diff) \(currencySymbol)"
    }
}
