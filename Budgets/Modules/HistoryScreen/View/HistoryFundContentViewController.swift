//
//  HistoryFundContentViewController.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 26.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class HistoryFundContentViewController: UIViewController {
    
    @IBOutlet weak var fundNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var balanceDateLabel: UILabel!
    
    @IBOutlet weak var tableView: HistoryFundsEntriesTableView!
    var presenter: HistoryFundsPageContentPresenterIntput?
    var contetnType: BFContetnType?
    var currencyCode: String?
    var funds: [Fund] = []
    var pageIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetup()
    }
    
    private func initialViewSetup() {
        prepareTableView()
        prepareLabels()
    }
    
    private func prepareTableView() {
        self.tableView.scrollingDelegate = self
        self.tableView.entries = self.funds.flatMap { $0.entries }
    }
    
    private func prepareLabels() {
        guard
            let _contentType = contetnType,
            let _currencyCode = currencyCode else { return }
        switch _contentType {
            
        case .total:
            self.fundNameLabel.text = "Total"
            
        case .normal, .savings:
            self.fundNameLabel.text = funds.first?.name ?? ""
            
        case .recurring:
            self.fundNameLabel.text = "Recurring"
        }
        
        let currencySymbol = CurrencyManager
            .getCurrencyFromCode(code: _currencyCode)?.symol ?? ""
        let amount = funds.map { $0.balance }.reduce(0, +)
        amountLabel.text = "\(amount) \(currencySymbol)"
        
        self.didScroll(visableEntries: self.funds.flatMap { $0.entries }, isAllVisable: true)
    }

}

extension HistoryFundContentViewController {
    static func getInstatnce(
        funds: [Fund],
        index: Int,
        contentType: BFContetnType,
        currencyCode: String,
        presenter: HistoryFundsPageContentPresenterIntput?
        ) -> UIViewController {
        
        guard let contentVC = UIStoryboard(name: HistoryScreenBuilder.storyBoardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: HistoryFundContentViewController.self)) as? HistoryFundContentViewController else {
            return UIViewController()
        }
        
        contentVC.funds = funds
        contentVC.pageIndex = index
        contentVC.contetnType = contentType
        contentVC.currencyCode = currencyCode
        contentVC.presenter = presenter
        return contentVC
        
    }
}

protocol HistoryFundsEntriesTVScrollDelegate {
    func didScroll(visableEntries: [FundEntry], isAllVisable: Bool)
}

extension HistoryFundContentViewController: HistoryFundsEntriesTVScrollDelegate {
    
    func didScroll(visableEntries: [FundEntry], isAllVisable: Bool) {
        
        guard
            visableEntries.count > 0,
            let firstEntry = visableEntries.first,
            let _currencyCode = currencyCode
            else {
                return
        }
        
        let budgetAmount = funds.map { $0.amount }.reduce(0, +)
        let amountSpent = visableEntries.map { $0.amount }.reduce(0, +)
        let currentAmount = budgetAmount + amountSpent
        let currentRoundedAmount = Double(round(100*currentAmount)/100)
        let currencySymbol = CurrencyManager
            .getCurrencyFromCode(code: _currencyCode)?.symol ?? ""
        let balanceText = "\(currentRoundedAmount) \(currencySymbol)"
        
        if self.amountLabel.text != balanceText {
            HapticFeedbackManager.shared.fireHapticSelection()
        }
        
        let entryDateString = firstEntry.date.string(for: .custom("dd MMMM"))
        let textToShow = isAllVisable ? "Current Balance" : "Balance on \(entryDateString)"
        
        amountLabel.text = balanceText
        self.balanceDateLabel.text = textToShow
    }
    
    
}
