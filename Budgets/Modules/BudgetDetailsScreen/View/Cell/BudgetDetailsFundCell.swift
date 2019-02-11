//
//  BudgetDetailsFundCell.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 11.02.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class BudgetDetailsFundCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var viewModel: BudgetDetailsFundCellVM? {
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

struct BudgetDetailsFundCellVM {
    let title: String
    let amount: String
}

extension BudgetDetailsFundCellVM {
    init(funds: [Fund], currencyCode: String) {
        
        let currencySymbol = CurrencyManager
            .getCurrencyFromCode(code: currencyCode)?.symol ?? ""
        let amountText = funds.map { $0.amount }.reduce(0, +)
        amount = "\(amountText) \(currencySymbol)"
        
        let fundTypes = funds.map { $0.type }.unique()
        guard let firstFundType = fundTypes.first else {
            title = ""
            return
        }
        
        switch firstFundType {

        case .recurring:
            self.title = "Recurring"
        default:
            self.title = funds.first?.name ?? ""
        }
        
    }
}
