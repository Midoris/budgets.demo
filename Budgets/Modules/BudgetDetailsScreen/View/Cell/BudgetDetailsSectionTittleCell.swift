//
//  BudgetDetailsSectionTittleCell.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 11.02.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class BudgetDetailsSectionTittleCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel: BudgetDetailsSectionTittleCellVM? {
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

struct BudgetDetailsSectionTittleCellVM {
    let title: String
}
