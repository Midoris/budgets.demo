//
//  HistoryFundContentViewController.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 26.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class HistoryFundContentViewController: UIViewController {
    
    @IBOutlet weak var tableView: HistoryFundsEntriesTableView!
    var presenter: HistoryFundsPageContentPresenterIntput?
    var contetnType: BFContetnType?
    var currencyCode: String?
    var funds: [Fund] = []
    var pageIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.presenter = presenter
        self.tableView.entries = self.funds.flatMap { $0.entries }
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
