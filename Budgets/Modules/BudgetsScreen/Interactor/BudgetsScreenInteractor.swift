//
//  BudgetsScreenInteractor.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 09.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import Foundation

protocol BudgetsScreenInteractorInput: class {
    func handle(command: BudgetsScreenInteractorCommand)
}

enum BudgetsScreenInteractorCommand {
}

class BudgetsScreenInteractor: BudgetsScreenInteractorInput {
    func handle(command: BudgetsScreenInteractorCommand) {
       
    }
}

extension BudgetsScreenInteractor {
    
}
