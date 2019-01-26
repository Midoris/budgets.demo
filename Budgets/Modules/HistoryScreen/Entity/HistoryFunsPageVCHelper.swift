//
//  HistoryFunsPageVCHelper.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 26.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

struct HistoryFunsPageVCHelper {
    
    static func getContentControllers(for funds: [Fund], and currencyCode: String) -> [UIViewController] {
        
        let recurringFunds = funds.filter { $0.type == .recurring }
        let normalFunds = funds.filter { $0.type == .normal }
        let savingFunds = funds.filter { $0.type == .saving }
        
        var controllers: [UIViewController] = []
        
        controllers.append(
            HistoryFundContentViewController.getInstatnce(funds: funds,
                                                          index: 0,
                                                          contentType: .total,
                                                          currencyCode: currencyCode)
        )
        
        if recurringFunds.count > 0 {
            controllers.append(
                HistoryFundContentViewController.getInstatnce(funds: recurringFunds,
                                                              index: controllers.count,
                                                              contentType: .recurring,
                                                              currencyCode: currencyCode)
            )
        }
        normalFunds.forEach { fund in
            controllers.append(
                HistoryFundContentViewController.getInstatnce(funds: [fund],
                                                              index: controllers.count,
                                                              contentType: .normal,
                                                              currencyCode: currencyCode)
            )
        }
        savingFunds.forEach { fund in
            controllers.append(
                HistoryFundContentViewController.getInstatnce(funds: [fund],
                                                              index: controllers.count,
                                                              contentType: .savings,
                                                              currencyCode: currencyCode)
            )
        }
        
        return controllers
    }
}