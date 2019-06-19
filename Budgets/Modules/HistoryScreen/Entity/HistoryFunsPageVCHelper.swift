//
//  HistoryFunsPageVCHelper.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 26.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

struct HistoryFunsPageVCHelper {
    
    static func getContentControllers(for funds: [Fund], and currencyCode: String, presenter: HistoryFundsPageContentPresenterIntput?, startDate: Date) -> [UIViewController] {
        
        let notIncomeFunds = funds.filter { $0.type != .income }
        let recurringFunds = funds.filter { $0.type == .recurring }
        let normalFunds = funds.filter { $0.type == .expense }
        let savingFunds = funds.filter { $0.type == .saving }
        
        var controllers: [UIViewController] = []
        
        controllers.append(
            HistoryFundContentViewController.getInstatnce(funds: notIncomeFunds,
                                                          index: 0,
                                                          contentType: .total,
                                                          currencyCode: currencyCode,
                                                          presenter: presenter,
                                                          startDate: startDate)
        )
        
        if recurringFunds.count > 0 {
            controllers.append(
                HistoryFundContentViewController.getInstatnce(funds: recurringFunds,
                                                              index: controllers.count,
                                                              contentType: .recurring,
                                                              currencyCode: currencyCode,
                                                              presenter: presenter,
                                                              startDate: startDate)
            )
        }
        normalFunds.forEach { fund in
            controllers.append(
                HistoryFundContentViewController.getInstatnce(funds: [fund],
                                                              index: controllers.count,
                                                              contentType: .normal,
                                                              currencyCode: currencyCode,
                                                              presenter: presenter,
                                                              startDate: startDate)
            )
        }
        savingFunds.forEach { fund in
            controllers.append(
                HistoryFundContentViewController.getInstatnce(funds: [fund],
                                                              index: controllers.count,
                                                              contentType: .savings,
                                                              currencyCode: currencyCode,
                                                              presenter: presenter,
                                                              startDate: startDate)
            )
        }
        
        return controllers
    }
}
