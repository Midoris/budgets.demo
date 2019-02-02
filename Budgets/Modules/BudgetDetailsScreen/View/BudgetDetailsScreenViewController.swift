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

}

class BudgetDetailsScreenViewController: UIViewController {
    var presenter: BudgetDetailsScreenPresenterInput?
    
    @IBOutlet weak var tableView: BudgetDetailsTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetup()
        presenter?.handle(event: .viewDidLoad)
    }
    
    private func initialViewSetup() {
        self.tableView.presenter = self.presenter
    }
    
}

extension BudgetDetailsScreenViewController: BudgetDetailsScreenViewPresenterOutput {
    
    func handle(command: BudgetDetailsScreenPresenterCommand) {
        switch command {

        }
    }
}

extension BudgetDetailsScreenViewController {

}
