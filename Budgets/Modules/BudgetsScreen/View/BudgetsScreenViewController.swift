//
//  BudgetsScreenViewController.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 09.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class BudgetsScreenViewController: UIViewController {

    
    @IBOutlet weak var tableView: BudgetsTableView!
    var presenter: BudgetsScreenPresenterInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViewSetup()
        presenter?.handle(event: .viewDidLoad)
    }
    
    private func initialViewSetup() {
        setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.presenter = self.presenter
    }

}

protocol BudgetsScreenPresenterOutput: class {
    var presenter: BudgetsScreenPresenterInput? { get set }
    func handle(command: BudgetsScreenPresenterCommand)
}

enum BudgetsScreenPresenterCommand {
    case updateTable(with: [Budget])
}

extension BudgetsScreenViewController: BudgetsScreenPresenterOutput {
    
    func handle(command: BudgetsScreenPresenterCommand) {
        switch command {
        case .updateTable(let budgets): self.tableView.budgets = budgets
        }
    }
}
