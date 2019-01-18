//
//  BalanceFunsPageViewController.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 15.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class BalanceFunsPageViewController: UIPageViewController {
    
    var presenter: BalanceFundsPageVCPresenterInput?
    var pages: [UIViewController] = []
    var currentIndex: Int = 0
    var pendingIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
    }
    
}


extension BalanceFunsPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let contetnBefore = viewController as? BalanceFundContentViewController else { return nil }
        return pages[safe: contetnBefore.pageIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let contetnBefore = viewController as? BalanceFundContentViewController else { return nil }
        return pages[safe: contetnBefore.pageIndex + 1]
    }

}

extension BalanceFunsPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let contentVC = pendingViewControllers.first as? BalanceFundContentViewController else { return }
        self.pendingIndex = contentVC.pageIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
        let newIndex = self.pendingIndex
        presenter?.handle(event: .didTransferToNewPage(newIndex))
    }
}

protocol BalanceFundsPageVCPresenterOutput: class {
    var presenter: BalanceFundsPageVCPresenterInput? { get set }
    func handle(command: BFPageViewCommand)
}

enum BFPageViewCommand {
    case prepareContetnt(funds: [Fund], currency: String)
}

extension BalanceFunsPageViewController: BalanceFundsPageVCPresenterOutput {
    
    func handle(command: BFPageViewCommand) {
        switch command {
        case .prepareContetnt(let funds, let currencyCode):
            
            let controllers = BalanceFunsPageVCHelper.getContentControllers(for: funds, and: currencyCode)
            
            self.pages = controllers
            
            if let _page = pages.first {
                self.setViewControllers([_page], direction: .forward, animated: true, completion: nil)
            }

        }
    }
}
