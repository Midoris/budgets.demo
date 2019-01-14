//
//  BalanceScreenViewController.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 14.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

protocol BalanceScreenViewPresenterOutput: class {
    var presenter: BalanceScreenPresenterInput? { get set }
    func handle(command: BalanceScreenPresenterCommand)
}

enum BalanceScreenPresenterCommand {

}

class BalanceScreenViewController: UIViewController {
    var presenter: BalanceScreenPresenterInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViewSetup()
        presenter?.handle(event: .viewDidLoad)
    }
    
    private func initialViewSetup() {
        
    }

}

extension BalanceScreenViewController: BalanceScreenViewPresenterOutput {
    
    func handle(command: BalanceScreenPresenterCommand) {

    }
}

extension BalanceScreenViewController {
    fileprivate func showSomeLabel() {
        
    }
}
