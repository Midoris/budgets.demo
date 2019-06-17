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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViewSetup()
        presenter?.handle(event: .viewDidLoad)
    }
    
    private func initialViewSetup() {
        self.view.addSubview(pageControl)
    }
    
    func setTitle(title:String, subtitle:String) -> UIView {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: -4, width: 0, height: 18))
        
        
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        titleLabel.text = title
        titleLabel.sizeToFit()
        
        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 20, width: 0, height: 14))
        subtitleLabel.backgroundColor = UIColor.clear
        subtitleLabel.textColor = UIColor.black
        subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()
        
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), height: 38))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)
        
        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width
        
        if widthDiff < 0 {
            let newX = widthDiff / 2
            subtitleLabel.frame.origin.x = abs(newX)
        } else {
            let newX = widthDiff / 2
            titleLabel.frame.origin.x = newX
        }
        
        return titleView
    }

}

extension HistoryScreenViewController: HistoryScreenViewPresenterOutput {
    
    func handle(command: HistoryScreenPresenterCommand) {
        switch command {
        case .updateUI(let budget):
            self.updateLabels(with: budget)
            let notIncomeFunds = budget.funds.filter { $0.type != .income }
            self.preparePageVC(funds: notIncomeFunds, currencyCode: budget.currencyCode)
        case .updatePageProgress(let index):
            self.updatePageProgress(index: index)
        }
    }
}

extension HistoryScreenViewController {
    
    private func updateLabels(with budget: Budget) {
        
        let month = budget.month
        let dates = "\(budget.startDate.string(for: .short)) - \(budget.endDate.string(for: .short))"
        self.navigationItem.titleView = setTitle(title: month, subtitle: dates)

    }
    
    private func preparePageVC(funds: [Fund], currencyCode: String) {
        guard let _pageVC = self.pageVC else { return }

        let tabBarHeight = self.tabBarController?.tabBar.bounds.height ?? 0
        let navBarHeight = navigationController?.navigationBar.frame.maxY ?? 0
        let topPadding: CGFloat = navBarHeight
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
