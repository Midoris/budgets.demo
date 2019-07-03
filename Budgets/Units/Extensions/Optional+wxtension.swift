//
//  Optional+wxtension.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 03.07.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import Foundation

precedencegroup LessOrMoreThenOptionsPrecedence {
    associativity: left
    higherThan: AdditionPrecedence
}

infix operator <? : LessOrMoreThenOptionsPrecedence
infix operator >? : LessOrMoreThenOptionsPrecedence
infix operator &&? : LessOrMoreThenOptionsPrecedence

func <? <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    if let lhs = lhs, let rhs = rhs {
        return lhs < rhs
    } else {
        return lhs == nil && rhs == nil
    }
}

func >? <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    if let lhs = lhs, let rhs = rhs {
        return lhs > rhs
    } else {
        return lhs == nil && rhs == nil
    }
}

func &&? (lhs: Bool?, rhs: Bool?) -> Bool {
    if let lhs = lhs, let rhs = rhs {
        return lhs && rhs
    } else {
        return lhs == nil && rhs == nil
    }
}
