//
//  Sequence+extensions.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 12.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter {
            if seen.contains($0) {
                return false
            } else {
                seen.insert($0)
                return true
            }
        }
    }
}

extension Sequence {
    func unorderedGroups<G: Hashable>(by predicate: (Element) -> G) -> [[Element]] {
        return Array(Dictionary(grouping: self, by: predicate).values)
    }
    
    func orderedGroups<G: Hashable>(by predicate: (Element) -> G,
                                    orderBy: ((Element, Element) -> Bool)) -> [[Element]] {
        
        let unorderedGroups = self.unorderedGroups(by: predicate)
        let orderedGroups = unorderedGroups.sorted(by: { orderBy($0[0], $1[0]) })
        return orderedGroups
        
    }
}
