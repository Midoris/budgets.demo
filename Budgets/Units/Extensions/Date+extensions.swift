//
//  Date+extensions.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 26.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import Foundation

extension Date {
    
    func days(since date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    func months(since date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    var yearByMonth: Int {
        return Calendar.current.component(.year, from: self) *
            Calendar.current.component(.month, from: self)
    }
    
    func isEqualUpToDay(to date: Date?) -> Bool {
        
        return self.day == date?.day
            && self.month == date?.month
            && self.year == date?.year
        
    }
    
}
