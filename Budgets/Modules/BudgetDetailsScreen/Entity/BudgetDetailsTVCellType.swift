//
//  BudgetDetailsTVCellType.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 02.02.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

enum BudgetDetailsTVCellType {
    case title(BudgetDetailsSectionTittleCellVM)
    case fund(BudgetDetailsFundCellVM)
    case sectionTotal(BudgetDetailsSectionTotalCellVM)
    case balance(BudgetDetailsTotalCellVM)
}

extension BudgetDetailsTVCellType {
    
    
    func cell(for tableView: BudgetDetailsTableView, at indexPath: IndexPath) -> UITableViewCell {
        
        switch self {
            
        case .title(let vm):
            let cell: BudgetDetailsSectionTittleCell = tableView.dequeueReusableCell(indexPath: indexPath)
            cell.viewModel = vm
            return cell
            
        case .fund(let vm):
            let cell: BudgetDetailsFundCell = tableView.dequeueReusableCell(indexPath: indexPath)
            cell.viewModel = vm
            return cell
            
        case .sectionTotal(let vm):
            let cell: BudgetDetailsSectionTotalCell = tableView.dequeueReusableCell(indexPath: indexPath)
            cell.viewModel = vm
            return cell
            
        case .balance(let vm):
            let cell: BudgetDetailsTotalCell = tableView.dequeueReusableCell(indexPath: indexPath)
            cell.viewModel = vm
            return cell
        }
        
    }
}
