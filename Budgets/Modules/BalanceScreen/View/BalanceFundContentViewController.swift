//
//  BalanceFundContentViewController.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 15.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class BalanceFundContentViewController: UIViewController {
    
    @IBOutlet weak var fundNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var contetnType: BFContetnType?
    var currencyCode: String?
    var funds: [Fund] = []
    var pageIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }

}

extension BalanceFundContentViewController {
    static func getInstatnce(
        funds: [Fund],
        index: Int,
        contentType: BFContetnType,
        currencyCode: String
        ) -> UIViewController {
        
        guard let contentVC = UIStoryboard(name: BalanceScreenBuilder.storyBoardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: BalanceFundContentViewController.self)) as? BalanceFundContentViewController else {
            return UIViewController()
        }
        
        contentVC.funds = funds
        contentVC.pageIndex = index
        contentVC.contetnType = contentType
        contentVC.currencyCode = currencyCode
        return contentVC
        
    }
}

enum BFContetnType {
    case total
    case recurring
    case normal
    case savings
}
