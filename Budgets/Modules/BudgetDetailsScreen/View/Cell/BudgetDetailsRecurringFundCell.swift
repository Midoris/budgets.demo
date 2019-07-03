//
//  BudgetDetailsRecurringFundCell.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 03.07.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class BudgetDetailsRecurringFundCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var viewModel: BudgetDetailsRecurringFundVM? {
        didSet {
            guard let vm = viewModel else { return }
            self.titleLabel.text = vm.title
            self.amountLabel.text = vm.amount
        }
    }

}


struct BudgetDetailsRecurringFundVM {
    let title: String
    let amount: String
    let fund: Fund
}

extension BudgetDetailsRecurringFundVM {
    init(fund: Fund, currencyCode: String) {
        
        self.fund = fund
        let currencySymbol = CurrencyManager
            .getCurrencyFromCode(code: currencyCode)?.symol ?? ""
        let amountText = fund.amount
        amount = "\(amountText) \(currencySymbol)"
        self.title = fund.name
    }
}
