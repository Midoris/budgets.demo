//
//  UserDefaultsManager.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 03.07.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import Foundation

struct UserDefaultsManager {
    
    static let defaults = UserDefaults.standard
    static let customFundTypesKey = "CustomFundTypesKey"
    
    static var customFundTypes: [FundType] {
        get {
            guard let typesNames = defaults.object(forKey: self.customFundTypesKey) as? [String] else {
                return []
            }
            return typesNames.map { FundType.custom($0) }
        }
        set {
            defaults.set(newValue.map { $0.name }, forKey: self.customFundTypesKey)
        }
    }
}
