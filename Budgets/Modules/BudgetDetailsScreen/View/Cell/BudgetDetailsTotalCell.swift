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
            self.titleLabel.textColor = vm.balanceColor
            self.amountLabel.textColor = vm.balanceColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }


}

struct BudgetDetailsTotalCellVM {
    let title: String
    let amount: String
    let balanceColor: UIColor
}

extension BudgetDetailsTotalCellVM {
    init(budget: Budget) {
        self.title = "Balance:"
        
        let currencySymbol = CurrencyManager
            .getCurrencyFromCode(code: budget.currencyCode)?.symol ?? ""
        let incomeFunds = budget.funds.filter { $0.type == .income }
        let notIncomeFunds = budget.funds.filter { $0.type != .income }
        let diff = incomeFunds.map { $0.amount }.reduce(0, +) - notIncomeFunds.map { $0.amount }.reduce(0, +)
        self.amount = "\(diff) \(currencySymbol)"
        balanceColor = diff >= 0 ? .green : .red
    }
}
