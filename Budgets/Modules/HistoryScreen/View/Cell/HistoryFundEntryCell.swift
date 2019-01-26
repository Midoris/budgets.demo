//
//  HistoryFundEntryCell.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 26.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class HistoryFundEntryCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var viewModel: HistoryFundEntryCellVM? {
        didSet {
            guard let vm = viewModel else { return }
            self.dateLabel.text = vm.date
            self.amountLabel.text = vm.amount
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}

struct HistoryFundEntryCellVM {
    let date: String
    let amount: String
    let entry: FundEntry
}

extension HistoryFundEntryCellVM {
    init(entry: FundEntry, currency: String) {
        self.entry =  entry
        self.date = entry.date.string(for: .short)
        self.amount = "\(entry.amount)"
    }
}
