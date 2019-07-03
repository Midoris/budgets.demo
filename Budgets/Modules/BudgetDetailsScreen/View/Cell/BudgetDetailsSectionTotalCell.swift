//
//  BudgetDetailsSectionTotalCell.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 11.02.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class BudgetDetailsSectionTotalCell: UITableViewCell {
    
    @IBOutlet weak var totalLabel: UILabel!
    
    var viewModel: BudgetDetailsSectionTotalCellVM? {
        didSet {
            guard let vm = viewModel else { return }
            self.totalLabel.text = vm.total
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }


}

struct BudgetDetailsSectionTotalCellVM {
    let total: String
}

extension BudgetDetailsSectionTotalCellVM {
    init(funds: [Fund], currencyCode: String) {
        
        let currencySymbol = CurrencyManager
            .getCurrencyFromCode(code: currencyCode)?.symol ?? ""
        let amountText = funds.map { $0.amount }.reduce(0, +)
        total = "\(amountText) \(currencySymbol)"
    }
}

