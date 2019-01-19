//
//  HistoryScreenViewController.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 19.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

protocol HistoryScreenViewPresenterOutput: class {
    var presenter: HistoryScreenPresenterInput? { get set }
    func handle(command: HistoryScreenPresenterCommand)
}

enum HistoryScreenPresenterCommand {
    case showSampleLabel
}

class HistoryScreenViewController: UIViewController {
    var presenter: HistoryScreenPresenterInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.handle(event: .viewDidLoad)
    }
    
    func sampleButtonTapped() {
        presenter?.handle(event: .sampleButtonTapped)
    }
}

extension HistoryScreenViewController: HistoryScreenViewPresenterOutput {
    
    func handle(command: HistoryScreenPresenterCommand) {
        switch command {
        case .showSampleLabel: self.showSomeLabel()
        }
    }
}

extension HistoryScreenViewController {
    fileprivate func showSomeLabel() {
        // Show some Label
    }
}
