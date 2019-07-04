//
//  BudgetCell2.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 04.07.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class BudgetCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var monthNameLabel: UILabel!
    @IBOutlet weak var datesLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var balanceTitleLabel: UILabel!
    @IBOutlet weak var balanceAmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        cardView.layer.cornerRadius = 8.0
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOpacity = 0.3
        cardView.layer.shadowRadius = 8.0
    }
    
    var viewModel: BudgetCell2ViewModel? {
        didSet {
            guard let vm = viewModel else { return }
            self.monthNameLabel.text = vm.monthName
            self.datesLabel.text = vm.dates
            self.balanceTitleLabel.text = vm.balanceTitle
            self.balanceAmountLabel.text = vm.balanceAmount
          
            vm.stackItems.enumerated().forEach { pair in
                let twoLabelView = TwoLabelsView(frame: .zero)
                twoLabelView.leftLabel.text = pair.element.0
                twoLabelView.rightLabel.text = pair.element.1
                self.stackView.insertArrangedSubview(twoLabelView, at: pair.offset)
            }
            
            self.balanceTitleLabel.textColor = vm.balanceColor
            self.balanceAmountLabel.textColor = vm.balanceColor
        }
    }
    
}

struct BudgetCell2ViewModel {
    let monthName: String
    let dates: String
    let stackItems: [(String, String)]
    let balanceTitle: String
    let balanceAmount: String
    let balanceColor: UIColor
}

extension BudgetCell2ViewModel {
    init(budget: Budget) {
        
        monthName = budget.month
        dates = "\(budget.startDate.string(for: .short)) - \(budget.endDate.string(for: .short))"
        
        let currencySymbol = CurrencyManager.getCurrencyFromCode(code: budget.currencyCode)?.symol ?? ""
        
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
        let notIncomeTotal = budget.funds
            .filter { $0.type != .income }
            .map { $0.amount }
            .reduce(0, +)
        
        var allCustomFunds: [Fund] = []
        budget.funds.forEach { fund in
            switch fund.type {
            case .custom:
                allCustomFunds.append(fund)
            default: break
            }
        }
        let groupedCustomFunds = allCustomFunds.unorderedGroups(by: { $0.type })
        
        var stackItemsTemp: [(String, String)] = []
        stackItemsTemp.append(("Income", "\(incomeTotal) \(currencySymbol)"))
        stackItemsTemp.append(("Expenses", "\(expensesTotal) \(currencySymbol)"))
        if savingsTotal > 0 {
            stackItemsTemp.append(("Savings", "\(savingsTotal) \(currencySymbol)"))
        }
        
        for group in groupedCustomFunds {
        
            guard let firstItem = group.first else { continue }
            
            let total = group
                .map { $0.amount }
                .reduce(0, +)
            if total > 0 {
                stackItemsTemp.append((firstItem.type.name, "\(total) \(currencySymbol)"))
            }
        }
        
        stackItems = stackItemsTemp
        
        balanceTitle = "Balance"
        balanceAmount = "\(incomeTotal - notIncomeTotal) \(currencySymbol)"
        balanceColor = incomeTotal - (expensesTotal + savingsTotal) >= 0 ? .green : .red
    }
}



