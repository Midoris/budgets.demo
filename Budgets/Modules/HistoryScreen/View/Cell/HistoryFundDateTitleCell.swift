//
//  HistoryFundDateTitleCell.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 26.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class HistoryFundDateTitleCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel: HistoryFundDateTitleCellVM? {
        didSet {
            guard let vm = viewModel else { return }
            self.titleLabel.text = vm.title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

struct HistoryFundDateTitleCellVM {
    let title: String
    let date: Date
}
