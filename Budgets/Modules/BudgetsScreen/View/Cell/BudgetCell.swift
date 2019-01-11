//
//  BudgetCell.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 10.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class BudgetCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var monthNameLabel: UILabel!
    @IBOutlet weak var datesLabel: UILabel!
    @IBOutlet weak var balanceTitleLabel: UILabel!
    @IBOutlet weak var balanceAmountLabel: UILabel!
    @IBOutlet weak var expenceTitleLabel: UILabel!
    @IBOutlet weak var expenceAmountLabel: UILabel!
    @IBOutlet weak var incomeTitleLabel: UILabel!
    @IBOutlet weak var incomeAmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        cardView.layer.cornerRadius = 8.0
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOpacity = 0.3
        cardView.layer.shadowRadius = 8.0
    }
    
    var viewModel: BudgetCellViewModel? {
        didSet {
            guard let vm = viewModel else { return }
            self.monthNameLabel.text = vm.monthName
            self.datesLabel.text = vm.dates
            self.balanceTitleLabel.text = vm.balanceTitle
            self.balanceAmountLabel.text = vm.balanceAmount
            self.expenceTitleLabel.text = vm.expenceTitle
            self.expenceAmountLabel.text = vm.expenceAmount
            self.incomeTitleLabel.text = vm.incomeTitle
            self.incomeAmountLabel.text = vm.incomeAmount
            self.balanceTitleLabel.textColor = vm.balanceColor
            self.balanceAmountLabel.textColor = vm.balanceColor
        }
    }

}

struct BudgetCellViewModel {
    let monthName: String
    let dates: String
    let balanceTitle: String
    let balanceAmount: String
    let expenceTitle: String
    let expenceAmount: String
    let incomeTitle: String
    let incomeAmount: String
    let balanceColor: UIColor
}

extension BudgetCellViewModel {
    init(budget: Budget) {
        
        monthName = budget.month
        dates = "\(budget.startDate.string(for: .short)) - \(budget.endDate.string(for: .short))"
        balanceTitle = "Balance"
        let incomeTotal = budget.incomeFunds
            .map { $0.amount }
            .reduce(0, +)
        let expensesTotal = budget.expensesFunds
            .map { $0.amount }
            .reduce(0, +)
        let currencySymbol = "€"
        balanceAmount = "\(incomeTotal - expensesTotal) \(currencySymbol)"
        expenceTitle = "Expence"
        expenceAmount = "\(expensesTotal) \(currencySymbol)"
        incomeTitle = "Income"
        incomeAmount = "\(incomeTotal) \(currencySymbol)"
        balanceColor = incomeTotal - expensesTotal >= 0 ? .green : .red
    }
}
