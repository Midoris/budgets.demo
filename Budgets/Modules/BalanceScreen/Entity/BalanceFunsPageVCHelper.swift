//
//  BalanceFunsPageVCHelper.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 18.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

struct BalanceFunsPageVCHelper {
    
    static func getContentControllers(for funds: [Fund], and currencyCode: String) -> [UIViewController] {
        
        let notIncomeFunds = funds.filter { $0.type != .income }
        let recurringFunds = funds.filter { $0.type == .recurring }
        let normalFunds = funds.filter { $0.type == .expense }
        let savingFunds = funds.filter { $0.type == .saving }
        
        var allCustomFundTypes: [Fund] = []
        funds.forEach { fund in
            switch fund.type {
            case .custom:
                allCustomFundTypes.append(fund)
            default: break
            }
        }
        
        let groupsOfCustomFunds = allCustomFundTypes.unorderedGroups(by: { $0.type })
        
        var controllers: [UIViewController] = []
        
        controllers.append(
            BalanceFundContentViewController.getInstatnce(funds: notIncomeFunds,
                                                          index: 0,
                                                          contentType: .total,
                                                          currencyCode: currencyCode)
        )
        
        if recurringFunds.count > 0 {
            controllers.append(
                BalanceFundContentViewController.getInstatnce(funds: recurringFunds,
                                                              index: controllers.count,
                                                              contentType: .recurring,
                                                              currencyCode: currencyCode)
            )
        }
        normalFunds.forEach { fund in
            controllers.append(
                BalanceFundContentViewController.getInstatnce(funds: [fund],
                                                              index: controllers.count,
                                                              contentType: .normal,
                                                              currencyCode: currencyCode)
            )
        }
        savingFunds.forEach { fund in
            controllers.append(
                BalanceFundContentViewController.getInstatnce(funds: [fund],
                                                              index: controllers.count,
                                                              contentType: .savings,
                                                              currencyCode: currencyCode)
            )
        }
        
        for group in groupsOfCustomFunds {
            guard let firstFund = group.first else { continue }
            controllers.append(
                BalanceFundContentViewController.getInstatnce(funds: group,
                                                              index: controllers.count,
                                                              contentType: .custom(firstFund.name),
                                                              currencyCode: currencyCode)
            )
            
        }
        
        return controllers
    }
}
