//
//  HistoryFundEntriesTableViewHelper.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 26.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit


struct HistoryFundEntriesTableViewHelper {
    
    static func prepareDataSource(entries: [FundEntry], currency: String) -> [HistoryFundsCellType] {
        
        let groups = Dictionary(grouping: entries) { ($0.date).yearByMonth }
        
        let groupedEntries = Array(groups.values).sorted { entry1, entry2 in
            guard let firstDate = entry1.first?.date,
                let secondDate = entry2.first?.date
                else { return false }
            return firstDate > secondDate
        }
        
        guard
            let closestMonth = groupedEntries.first
            
            else {
                let types = groupedEntries
                    .map { getMonthCells(entries: $0, currency: currency) }
                    .flatMap { $0 }
                
                return types
        }
        
        var todayEntries: [FundEntry] = []
        var yeasterdayEntries: [FundEntry] = []
        var otherEntries: [FundEntry] = []
        
        for entry in closestMonth {
            let date = entry.date
            switch date {
            case let d where Calendar.current.isDateInToday(d) == true : todayEntries.append(entry)
            case let d where Calendar.current.isDateInYesterday(d) == true : yeasterdayEntries.append(entry)
            default: otherEntries.append(entry)
            }
        }
        
        switch (todayEntries.count, yeasterdayEntries.count) {
            
        case (let today, let yesterday) where today > 0 && yesterday > 0:
            
            var allTypes: [HistoryFundsCellType] = []
            let todayTypes = getMonthCells(entries: todayEntries, currency: currency)
            let yeasterdayTypes = getMonthCells(entries: yeasterdayEntries, currency: currency)
            let other = getMonthCells(entries: otherEntries, currency: currency)
            
            allTypes.append(contentsOf: todayTypes)
            allTypes.append(contentsOf: yeasterdayTypes)
            allTypes.append(contentsOf: other)
            
            let otherMOnths = groupedEntries.dropFirst()
            
            let types = otherMOnths
                .map { getMonthCells(entries: $0, currency: currency) }
                .flatMap { $0 }
            
            allTypes.append(contentsOf: types)
            return allTypes
            
            
        case (let today, _) where today > 0:
            
            var allTypes: [HistoryFundsCellType] = []
            let todayTypes = getMonthCells(entries: todayEntries, currency: currency)
            let other = getMonthCells(entries: otherEntries, currency: currency)
            allTypes.append(contentsOf: todayTypes)
            allTypes.append(contentsOf: other)
            
            let otherMOnths = groupedEntries.dropFirst()
            
            let types = otherMOnths
                .map { getMonthCells(entries: $0, currency: currency) }
                .flatMap { $0 }
            
            allTypes.append(contentsOf: types)
            return allTypes
            
        case (_, let yesterday) where yesterday > 0:
            
            var allTypes: [HistoryFundsCellType] = []
            let yeasterdayTypes = getMonthCells(entries: yeasterdayEntries, currency: currency)
            let other = getMonthCells(entries: otherEntries, currency: currency)
            
            allTypes.append(contentsOf: yeasterdayTypes)
            allTypes.append(contentsOf: other)
            
            let otherMOnths = groupedEntries.dropFirst()
            
            let types = otherMOnths
                .map { getMonthCells(entries: $0, currency: currency) }
                .flatMap { $0 }
            
            allTypes.append(contentsOf: types)
            return allTypes
            
            
        default:
            
            let types = groupedEntries
                .map { getMonthCells(entries: $0, currency: currency) }
                .flatMap { $0 }
            
            return types
            
        }
        
    }
    
    static func getMonthCells(entries: [FundEntry], currency: String) -> [HistoryFundsCellType] {
        
        guard let firstDate = entries.first?.date else { return [] }
        
        var types: [HistoryFundsCellType] = []
        let titleType = self.getHeaderCellType(for: firstDate)
        
        types.append(titleType)
        
        for entry in entries {
            
            let entryType = self.getEntryCellType(for: entry, currency: currency)
            types.append(entryType)
        }
        
        return types
    }
    
    static func getHeaderCellType(for date: Date) -> HistoryFundsCellType {
        
        let isToday = Calendar.current.isDateInToday(date)
        let isYesterday = Calendar.current.isDateInYesterday(date)
        
        var titleText = ""
        if isToday {
            titleText = "Today"
        } else if isYesterday {
            titleText = "Yesterday"
        } else {
            
            let dateformatter = DateFormatter()
            let todayDate = Date()
            let thisYear = Calendar.current.component(.year, from: todayDate)
            let entryYear = Calendar.current.component(.year, from: date)
            
            dateformatter.dateFormat = thisYear == entryYear ? "MMMM" : "MMMM, yyyy"
            titleText = dateformatter.string(from: date)
        }
        
        let titleVM = HistoryFundDateTitleCellVM(title: titleText, date: date)
        let titleType = HistoryFundsCellType.title(titleVM)
        
        return titleType
    }
    
    static func getEntryCellType(for entry: FundEntry, currency: String) -> HistoryFundsCellType {
        let vm = HistoryFundEntryCellVM(entry: entry, currency: currency)
        let entryType = HistoryFundsCellType.entry(vm)
        return entryType
    }
    
    
    static func getIndexForJustCellInsetion(
        ds: [HistoryFundsCellType],
        alternativeHeaderTyep: HistoryFundsCellType,
        entryDate: Date
        ) -> Int {
        
        let cellIndex = ds.enumerated().map { (index, type) -> (Int, HistoryFundsCellType) in
            return (index, type)
        }
        
        var cellsAfter = cellIndex.filter { (index, type) in
            
            switch type {
            case .entry(let vm): return vm.entry.date < entryDate
            case .title(let vm):
                
                switch alternativeHeaderTyep {
                    
                case .title(let _vm):
                    let shouldUseDate = _vm.title != vm.title
                    return shouldUseDate ? vm.date < entryDate : false
                    
                case .entry: return false
                }
            }
        }
        
        cellsAfter.sort { $0.0 < $1.0 }
        
        if let index = cellsAfter.first?.0 {
            return index
        } else {
            guard let lastIndex = (cellIndex.sorted { $0.0 < $1.0 }).last else { return 0 }
            return lastIndex.0 + 1
        }
        
    }
    
    static func getIndexForHeaderAndCellInsetion(
        ds: [HistoryFundsCellType],
        alternativeHeaderTyep: HistoryFundsCellType,
        entryDate: Date
        ) -> Int {
        
        
        let cellIndex = ds.enumerated().map { (index, type) -> (Int, HistoryFundsCellType) in
            return (index, type)
        }
        
        var cellsAfter = cellIndex.filter { (index, type) in
            
            switch type {
            case .entry(let vm): return vm.entry.date < entryDate
            case .title(let vm): return vm.date < entryDate
            }
            
        }
        
        cellsAfter.sort { $0.0 < $1.0 }
        if let index = cellsAfter.first?.0 {
            return index
        } else {
            
            guard let lastIndex = (cellIndex.sorted { $0.0 < $1.0 }).last else { return 0 }
            return lastIndex.0 + 1
        }
        
    }
    
    static func haveMatchingTitle(ds: [HistoryFundsCellType], dateID: Int, alternativeHeaderTyep: HistoryFundsCellType) -> Bool {
        
        let matchingHeaders = ds.filter { type in
            
            switch type {
            case .entry: return false
            case .title(let vm): return vm.date.yearByMonth == dateID
            }
        }
        
        let matchingTitles = matchingHeaders.map { (type) -> String in
            switch type {
            case .title(let vm): return vm.title
            case .entry: return ""
            }
        }
        
        let sameTitleHeaders = matchingTitles.filter { title in
            
            switch alternativeHeaderTyep {
            case .title(let vm): return title == vm.title
            case .entry: return false
            }
            
        }
        
        return sameTitleHeaders.count == 1
    }
    
}

