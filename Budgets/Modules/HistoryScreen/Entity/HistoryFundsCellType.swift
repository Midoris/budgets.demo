//
//  HistoryFundsCellType.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 26.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

enum HistoryFundsCellType {
    case title(HistoryFundDateTitleCellVM)
    case entry(HistoryFundEntryCellVM)
}

extension HistoryFundsCellType {
    func cell(for tableView: HistoryFundsEntriesTableView, at indexPath: IndexPath) -> UITableViewCell {
        
        switch self {
            
        case .title(let vm):
            let cell: HistoryFundDateTitleCell = tableView.dequeueReusableCell(indexPath: indexPath)
            cell.viewModel = vm
            return cell
            
        case .entry(let vm):
            let cell: HistoryFundEntryCell = tableView.dequeueReusableCell(indexPath: indexPath)
            cell.viewModel = vm
            return cell
        }
        
    }
}
