//
//  BudgetDetailsScreenViewController.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 02.02.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

protocol BudgetDetailsScreenViewPresenterOutput: class {
    var presenter: BudgetDetailsScreenPresenterInput? { get set }
    func handle(command: BudgetDetailsScreenPresenterCommand)
}

enum BudgetDetailsScreenPresenterCommand {
    case showSampleLabel
}

class BudgetDetailsScreenViewController: UIViewController {
    var presenter: BudgetDetailsScreenPresenterInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.handle(event: .viewDidLoad)
    }
    
    func sampleButtonTapped() {
        presenter?.handle(event: .sampleButtonTapped)
    }
}

extension BudgetDetailsScreenViewController: BudgetDetailsScreenViewPresenterOutput {
    
    func handle(command: BudgetDetailsScreenPresenterCommand) {
        switch command {
        case .showSampleLabel: self.showSomeLabel()
        }
    }
}

extension BudgetDetailsScreenViewController {
    fileprivate func showSomeLabel() {
        // Show some Label
    }
}
