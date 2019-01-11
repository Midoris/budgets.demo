//
//  Reusable.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 11.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

protocol Reusable: class {
    static var reuseIdentifier: String { get }
}
extension Reusable {
    static var reuseIdentifier: String { return String(describing: self) }
}

protocol NibReusable: Reusable {
    static var nib: UINib { get }
}
extension NibReusable {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
