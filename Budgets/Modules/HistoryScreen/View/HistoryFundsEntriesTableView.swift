//
//  HistoryFundsEntriesTableView.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 26.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class HistoryFundsEntriesTableView: UITableView {
    
    var scrollingDelegate: HistoryFundsEntriesTVScrollDelegate? {
        didSet {
            self.dataSource = self
            self.delegate = self
            self.tableFooterView = UIView()
        }
    }
    
    var entries: [FundEntry] = [] {
        didSet {
            self.ds = HistoryFundEntriesTableViewHelper.prepareDataSource(entries: entries.sorted { $0.date > $1.date }, currency: "EUR")
        }
    }
    var ds: [HistoryFundsCellType] = [] {
        didSet {
            self.reloadData()
        }
    }

}

extension HistoryFundsEntriesTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let type = ds[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        return type.cell(for: self, at: indexPath)
    }
    
    
}

extension HistoryFundsEntriesTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}

extension HistoryFundsEntriesTableView {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard let topVisibleIndexPath:IndexPath = self.indexPathsForVisibleRows?.first else {
            self.scrollingDelegate?.didScrollToBottom()
            return
            
        }
        
        let allEntries: [FundEntry] = self.ds.map { type -> FundEntry? in
            switch type {
            case .entry(let vm): return vm.entry
            case .title: return nil
            }
            }.compactMap { $0 }
        
        guard let visibleCellType = ds[safe: topVisibleIndexPath.row] else { return }
        
        
        switch visibleCellType {
        case .entry(let vm):
            
            // calculate balance after this entry index
            guard let index = allEntries.index(of: vm.entry) else { return }
            
            let visableEntries = Array(allEntries.suffix(from: index))
            let isAllVisable = allEntries.count == visableEntries.count

            self.scrollingDelegate?.didScroll(visableEntries: visableEntries, isAllVisable: isAllVisable)
            
        case .title:
            
            guard let entryType = ds[safe: topVisibleIndexPath.row + 1] else { return }
            switch entryType {
            case .entry(let vm):
                
                guard let index = allEntries.index(of: vm.entry) else { return }
                
                let visableEntries = Array(allEntries.suffix(from: index))
                let isAllVisable = allEntries.count == visableEntries.count

                self.scrollingDelegate?.didScroll(visableEntries: visableEntries, isAllVisable: isAllVisable)
                
            default: break
            }
            
        }
        
        
    }
}
