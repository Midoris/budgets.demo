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
    case updateUI(Budget)
    case updatePageProgress(Int)
}

class HistoryScreenViewController: UIViewController {
    var presenter: HistoryScreenPresenterInput?
    var pageVC: HistoryFunsPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.handle(event: .viewDidLoad)
    }

}

extension HistoryScreenViewController: HistoryScreenViewPresenterOutput {
    
    func handle(command: HistoryScreenPresenterCommand) {
        switch command {
        case .updateUI(let budget):
            self.updateLabels(with: budget)
            self.preparePageVC(funds: budget.expensesFunds, currencyCode: budget.currencyCode)
        case .updatePageProgress(let index):
            self.updatePageProgress(index: index)
        }
    }
}

extension HistoryScreenViewController {
    private func updateLabels(with budget: Budget) {
        // TODO: Update labels
    }
    
    private func preparePageVC(funds: [Fund], currencyCode: String) {
        guard let _pageVC = self.pageVC else { return }

        let tabBarHeight = self.tabBarController?.tabBar.bounds.height ?? 0
        let topPadding: CGFloat = 240
        
        _pageVC.view.frame = CGRect(
            x: 0,
            y: topPadding,
            width: self.view.bounds.width,
            height: self.view.bounds.height - (tabBarHeight + topPadding)
        )
        self.view.addSubview(_pageVC.view)
        _pageVC.didMove(toParent: self)
    }
    
    private func updatePageProgress(index: Int) {

    }
}
