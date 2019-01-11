//
//  DateFormatterManager.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 10.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import Foundation

enum CachedDateFormatter: Hashable, Equatable {
    case ISO8601
    case littleEndian
    case bigEndian
    case short
    case shortMonthInWords
    case shortTimeFormate
    case long
    case reverse
    case dayMonthDate
    case custom(String)
}

extension CachedDateFormatter {
    var value: String {
        switch self {
            
        case .ISO8601:
            return "yyyy-MM-dd'T'HH:mm:ss"
        case .littleEndian:
            return "dd-MM-yyyy"
        case .bigEndian:
            return "yyyy-MM-dd"
        case .short:
            return "d. MMM YYYY"//"EEE, dd MMM" "EEE, dd. MMM."
        case .shortMonthInWords:
            return "dd MMM"
        case .shortTimeFormate:
            return "HH:mm"
        case .long:
            return  "EEEE, dd MMM" //"EEEE, dd. MMM.": "EEEE, dd MMM"
        case .reverse:
            return "yyyyMMdd"
        case .dayMonthDate:
            return "EEEE, MMMM dd"
        case .custom(let formate):
            return formate
        }
    }
}

fileprivate final class DateFormatterManager {
    
    static let shared = DateFormatterManager()
    
    private var cached: [CachedDateFormatter: DateFormatter] = [:]
    
    func cached(formate: CachedDateFormatter) -> DateFormatter {
        if let formatter = cached[formate] {
            return formatter
            
        } else {
            
            let formatter = DateFormatter()
            formatter.dateFormat = formate.value
            formatter.timeZone = TimeZone.autoupdatingCurrent
            formatter.locale = Locale.current
            formatter.isLenient = true
            
            self.cached[formate] = formatter
            
            return formatter
        }
    }
}

extension String {
    func date(for formatter: CachedDateFormatter) -> Date? {
        return DateFormatterManager.shared
            .cached(formate: formatter)
            .date(from: self)
    }
}

extension Date {
    func string(for formatter: CachedDateFormatter) -> String {
        return DateFormatterManager.shared
            .cached(formate: formatter)
            .string(from: self)
    }
}
