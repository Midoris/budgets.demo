//
//  CurrencyManager.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 12.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import Foundation

struct Currency: Hashable, Equatable  {
    let code: String
    let symol: String
    let name: String
}

struct CurrencyManager {
    
    static func getCurrencies() -> [Currency] {
        
        var allCurrencies: [Currency] = []
        
        self.allCurrencyCodes.forEach { code in
            let symbol = symbols[code] ?? getSymbol(forCurrencyCode: code) ?? ""
            let name = getName(forCurrencyCode: code) ?? ""
            let currency = Currency(
                code: code,
                symol: symbol,
                name: name
            )
            allCurrencies.append(currency)
            
        }
        
        return allCurrencies.sorted { $0.name < $1.name }
        
    }
    
    static func getCurrencyFromCode(code: String) -> Currency? {
        let allCurrensies = getCurrencies()
        guard let matchingCurrency = (allCurrensies.first { $0.code == code }) else { return nil }
        return matchingCurrency
    }
    
    static private let nameLocale = NSLocale(localeIdentifier: "US")
    
    static private var allCurrencyCodes = Locale.commonISOCurrencyCodes
    
    static private func getSymbol(forCurrencyCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        if locale.displayName(forKey: .currencySymbol, value: code) == code {
            let newlocale = NSLocale(localeIdentifier: code.dropLast() + "_en")
            return newlocale.displayName(forKey: .currencySymbol, value: code)
        }
        return locale.displayName(forKey: .currencySymbol, value: code)
    }
    
    static private func getName(forCurrencyCode code: String) -> String? {
        return nameLocale.displayName(forKey: NSLocale.Key.currencyCode, value: code)
    }
    
    static private let symbols: [String: String] = [
        "AED": "د.إ.‏",
        "AFN": "؋",
        "XCD": "$",
        "ALL": "ALL",
        "AMD": "֏",
        "AOA": "Kz",
        "ARS": "ARS",
        "AWG": "AWG",
        "AZN": "₼",
        "BAM": "KM",
        "BBD": "BBD",
        "BDT": "৳",
        "BGN": "BGN",
        "BHD": "د.ب.‏",
        "BIF": "FBu",
        "BMD": "$",
        "BND": "$",
        "BOB": "Bs",
        "BRL": "R$",
        "BSD": "$",
        "BTN": "Nu.",
        "BWP": "P",
        "BYN": "Br",
        "BZD": "$",
        "CAD": "$",
        "CDF": "₣",
        "CLP": "$",
        "XAF": "₣",
        "CNY": "¥",
        "COP": "$",
        "CRC": "₡",
        "CUP": "$",
        "CVE": "​$",
        "CZK": "Kč",
        "DJF": "₣",
        "DOP": "$",
        "DZD": "د.ج",
        "EUR": "€",
        "USD": "$",
        "EGP": "ج.م.‏",
        "ERN": "Nfk",
        "ETB": "Br",
        "FJD": "$",
        "FKP": "£",
        "GBP": "£",
        "GEL": "₾",
        "GHS": "₵",
        "GIP": "£",
        "DKK": "kr",
        "GMD": "D",
        "GNF": "₣",
        "GTQ": "Q",
        "GYD": "$",
        "HKD": "$",
        "HNL": "L",
        "HRK": "Kn",
        "HTG": "G",
        "HUF": "Ft",
        "IDR": "Rp",
        "ILS": "₪",
        "INR": "₹",
        "IQD": "د.ع.‏",
        "IRR": "ریال",
        "ISK": "Kr",
        "JMD": "$",
        "JOD": "د.أ.‏",
        "JPY": "¥",
        "KES": "Sh",
        "KGS": "сом",
        "KHR": "៛",
        "KMF": "CF",
        "KPW": "₩",
        "KRW": "₩",
        "KWD": "د.ك.‏",
        "KYD": "$",
        "KZT": "₸",
        "LAK": "₭",
        "LBP": "ل.ل.‏",
        "CHF": "₣",
        "LKR": "රු.",
        "LRD": "$",
        "LYD": "د.ل.‏",
        "MAD": "د.م.",
        "MDL": "L",
        "MGA": "Ar",
        "MKD": "ден",
        "MMK": "K",
        "MNT": "₮",
        "MOP": "P",
        "MRU": "MRU",
        "MUR": "Rs",
        "MVR": "ރ.",
        "MWK": "MK",
        "MXN": "$",
        "MYR": "RM",
        "MZN": "MTn",
        "NAD": "$",
        "AUD": "$",
        "NGN": "₦",
        "NIO": "C$",
        "NOK": "kr",
        "NPR": "नेरू",
        "OMR": "ر.ع.‏",
        "PAB": "B/.",
        "PEN": "S/",
        "XPF": "₣",
        "PGK": "K",
        "PHP": "₱",
        "PKR": "Rs",
        "PLN": "zł",
        "NZD": "$",
        "PYG": "₲",
        "QAR": "ر.ق.‏",
        "RON": "L",
        "RSD": "din",
        "RUB": "₽",
        "RWF": "₣",
        "SAR": "ر.س.‏",
        "SBD": "$",
        "SCR": "₨",
        "SDG": "ج.س.",
        "SEK": "kr",
        "SGD": "$",
        "SHP": "£",
        "SLL": "Le",
        "SOS": "S",
        "SRD": "$",
        "SSP": "£",
        "STN": "Db",
        "ANG": "ANG",
        "SYP": "ل.س",
        "SZL": "L",
        "XOF": "CFA",
        "THB": "฿",
        "TJS": "ЅМ",
        "TMT": "m",
        "TND": "د.ت",
        "TOP": "T$",
        "TRY": "₺",
        "TTD": "$",
        "TWD": "$",
        "TZS": "Sh",
        "UAH": "₴",
        "UGX": "Sh",
        "UYU": "$",
        "UZS": "soʻm",
        "VEF": "Bs F",
        "VND": "₫",
        "VUV": "Vt",
        "WST": "T",
        "YER": "ر.ي.‏",
        "ZAR": "R",
        "ZMW": "ZK",
        ]
}
