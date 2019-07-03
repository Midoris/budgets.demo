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
    case updateUI(Budget)
    case updatePageProgress(Int)
}

class BalanceScreenViewController: UIViewController {
    
    var presenter: BalanceScreenPresenterInput?
    @IBOutlet weak var monthNameLabel: UILabel!
    @IBOutlet weak var budgetDatesLabel: UILabel!
    var pageVC: BalanceFunsPageViewController?
    let pageControl = CHIPageControlChimayo(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViewSetup()
        presenter?.handle(event: .viewDidLoad)
    }
    
    private func initialViewSetup() {
        self.view.addSubview(pageControl)
    }

}

extension BalanceScreenViewController: BalanceScreenViewPresenterOutput {
    
    func handle(command: BalanceScreenPresenterCommand) {
        switch command {
            
        case .updateUI(let budget):
            self.updateLabels(with: budget)
            
            self.preparePageVC(funds: budget.funds, currencyCode: budget.currencyCode)
            
        case .updatePageProgress(let index):
            self.updatePageProgress(index: index)
        }
    }
}

extension BalanceScreenViewController {
    private func updateLabels(with budget: Budget) {
        self.monthNameLabel.text = budget.month
        self.budgetDatesLabel.text = "\(budget.startDate.string(for: .short)) - \(budget.endDate.string(for: .short))"
    }
    
    private func preparePageVC(funds: [Fund], currencyCode: String) {
        guard let _pageVC = self.pageVC else { return }
        _pageVC.view.frame = CGRect(x: 0, y: 240.0, width: self.view.bounds.width, height: 240.0)
        self.view.addSubview(_pageVC.view)
        _pageVC.didMove(toParent: self)
        
        let controllers = BalanceFunsPageVCHelper.getContentControllers(for: funds, and: currencyCode)
        
        pageControl.frame = CGRect(x: 0.0, y: _pageVC.view.frame.maxY + 16.0, width: self.view.bounds.width, height: 32.0)
        pageControl.numberOfPages = controllers.count
        pageControl.radius = 4
        pageControl.tintColor = .white
        pageControl.currentPageTintColor = .white
        pageControl.padding = 6
    }
    
    private func updatePageProgress(index: Int) {
        pageControl.set(progress: index, animated: true)
    }
}
