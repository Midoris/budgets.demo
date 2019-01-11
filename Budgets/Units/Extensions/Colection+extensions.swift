//
//  Colection+extensions.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 11.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
