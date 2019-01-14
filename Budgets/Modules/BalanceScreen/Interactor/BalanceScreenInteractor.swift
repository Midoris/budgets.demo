//
//  BalanceScreenInteractor.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 14.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import Foundation

protocol BalanceScreenInteractorInput: class {
    func handle(command: BalanceScreenInteractorCommand)
}

enum BalanceScreenInteractorCommand {
}

class BalanceScreenInteractor: BalanceScreenInteractorInput {
    func handle(command: BalanceScreenInteractorCommand) {
    }
}

extension BalanceScreenInteractor {

}
