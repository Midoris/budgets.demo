//
//  BudgetDetailsScreenInteractor.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 02.02.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import Foundation

protocol BudgetDetailsScreenInteractorInput: class {
    func handle(command: BudgetDetailsScreenInteractorCommand)
}

enum BudgetDetailsScreenInteractorCommand {
    case sampleWork
}

class BudgetDetailsScreenInteractor: BudgetDetailsScreenInteractorInput {
    func handle(command: BudgetDetailsScreenInteractorCommand) {
        switch command {
        case .sampleWork: self.doSampleWork()
        }
    }
}

extension BudgetDetailsScreenInteractor {
    fileprivate func doSampleWork() {
        // do Sample Work
    }
}
