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
    let pageControl = CHIPageControlChimayo(frame: CGRect.zero)
    @IBOutlet weak var monthNameLabel: UILabel!
    @IBOutlet weak var budgetDatesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViewSetup()
        presenter?.handle(event: .viewDidLoad)
    }
    
    private func initialViewSetup() {
        self.view.addSubview(pageControl)
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
        self.monthNameLabel.text = budget.month
        self.budgetDatesLabel.text = "\(budget.startDate.string(for: .short)) - \(budget.endDate.string(for: .short))"
    }
    
    private func preparePageVC(funds: [Fund], currencyCode: String) {
        guard let _pageVC = self.pageVC else { return }

        let tabBarHeight = self.tabBarController?.tabBar.bounds.height ?? 0
        let topPadding: CGFloat = 240
        let pageControlHeight: CGFloat = 32.0
        
        _pageVC.view.frame = CGRect(
            x: 0,
            y: topPadding,
            width: self.view.bounds.width,
            height: self.view.bounds.height - (tabBarHeight + topPadding + pageControlHeight)
        )
        self.view.addSubview(_pageVC.view)
        _pageVC.didMove(toParent: self)
        
        let controllers = HistoryFunsPageVCHelper.getContentControllers(
            for: funds,
            and: "",
            presenter: nil
        )
        
        pageControl.frame = CGRect(x: 0.0, y: _pageVC.view.frame.maxY, width: self.view.bounds.width, height: pageControlHeight)
        pageControl.numberOfPages = controllers.count
        pageControl.radius = 4
        pageControl.tintColor = UIColor.yellowBackground
        pageControl.currentPageTintColor = .white
        pageControl.padding = 6
    }
    
    private func updatePageProgress(index: Int) {
        pageControl.set(progress: index, animated: true)
    }
}
