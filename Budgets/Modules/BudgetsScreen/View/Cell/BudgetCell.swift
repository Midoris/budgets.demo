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
    @IBOutlet weak var expenseTitleLabel: UILabel!
    @IBOutlet weak var expenseAmountLabel: UILabel!
    @IBOutlet weak var incomeTitleLabel: UILabel!
    @IBOutlet weak var incomeAmountLabel: UILabel!
    @IBOutlet weak var savingsTitleLabel: UILabel!
    @IBOutlet weak var savingsAmountLabel: UILabel!
    
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
            self.expenseTitleLabel.text = vm.expenseTitle
            self.expenseAmountLabel.text = vm.expenseAmount
            self.incomeTitleLabel.text = vm.incomeTitle
            self.incomeAmountLabel.text = vm.incomeAmount
            self.savingsTitleLabel.text = vm.savingsTitle
            self.savingsAmountLabel.text = vm.savingsAmount
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
    let expenseTitle: String
    let expenseAmount: String
    let incomeTitle: String
    let incomeAmount: String
    let balanceColor: UIColor
    let savingsTitle: String
    let savingsAmount: String
}

extension BudgetCellViewModel {
    init(budget: Budget) {
        
        monthName = budget.month
        dates = "\(budget.startDate.string(for: .short)) - \(budget.endDate.string(for: .short))"
        balanceTitle = "Balance"
        let incomeFunds = budget.funds.filter { $0.type == .income }
        let incomeTotal = incomeFunds
            .map { $0.amount }
            .reduce(0, +)
        let expensesTotal = budget.funds.filter { $0.type == .expense || $0.type == .recurring }
            .map { $0.amount }
            .reduce(0, +)
        let savingsTotal = budget.funds.filter { $0.type == .saving }
            .map { $0.amount }
            .reduce(0, +)
        let currencySymbol = CurrencyManager.getCurrencyFromCode(code: budget.currencyCode)?.symol ?? ""
        balanceAmount = "\(incomeTotal - (expensesTotal + savingsTotal)) \(currencySymbol)"
        expenseTitle = "Expenses"
        expenseAmount = "\(expensesTotal) \(currencySymbol)"
        incomeTitle = "Income"
        incomeAmount = "\(incomeTotal) \(currencySymbol)"
        savingsTitle = "Savings"
        savingsAmount = "\(savingsTotal) \(currencySymbol)"
        balanceColor = incomeTotal - (expensesTotal + savingsTotal) >= 0 ? .green : .red
    }
}
