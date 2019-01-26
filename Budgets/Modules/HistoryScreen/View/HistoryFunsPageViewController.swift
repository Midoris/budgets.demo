//
//  HistoryFunsPageViewController.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 26.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class HistoryFunsPageViewController: UIPageViewController {
    
    var presenter: HistoryFundsPageVCPresenterIntput?
    var pages: [UIViewController] = []
    var currentIndex: Int = 0
    var pendingIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
    }
    
}

extension HistoryFunsPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let contetnBefore = viewController as? HistoryFundContentViewController else { return nil }
        return pages[safe: contetnBefore.pageIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let contetnBefore = viewController as? HistoryFundContentViewController else { return nil }
        return pages[safe: contetnBefore.pageIndex + 1]
    }
    
}

extension HistoryFunsPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let contentVC = pendingViewControllers.first as? HistoryFundContentViewController else { return }
        self.pendingIndex = contentVC.pageIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
        let newIndex = self.pendingIndex
        presenter?.handle(event: .didTransferToNewPage(newIndex))
    }
}


protocol HistoryFundsPageVCPresenterOutput: class {
    var presenter: HistoryFundsPageVCPresenterIntput? { get set }
    func handle(command: HFPageViewCommand)
}

enum HFPageViewCommand {
    case prepareContetnt(funds: [Fund], currency: String)
}

extension HistoryFunsPageViewController: HistoryFundsPageVCPresenterOutput {
    func handle(command: HFPageViewCommand) {
        switch command {
            
        case .prepareContetnt(let funds, let currencyCode):
            
            let controllers = HistoryFunsPageVCHelper.getContentControllers(
                for: funds,
                and: currencyCode,
                presenter: self.presenter as? HistoryFundsPageContentPresenterIntput
            )

            self.pages = controllers
            
            if let _page = pages.first {
                self.setViewControllers([_page], direction: .forward, animated: true, completion: nil)
            }
        }
    }
}
