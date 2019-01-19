//
//  HistoryScreenRouter.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 19.01.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

protocol HistoryScreenRouterInput: class {
    var viewController: UIViewController? { get set }
    func presentView(container: UIResponder?)
    func handle(route: HistoryScreenRoute)
}

enum HistoryScreenRoute {
    case someScreen
}

class HistoryScreenRouter {
    weak var viewController: UIViewController?
}

extension HistoryScreenRouter: HistoryScreenRouterInput {
    
    func presentView(container: UIResponder?) {
        guard
            let parentView = container as? UIViewController,
            let viewController = self.viewController
            else { return }
        parentView.present(viewController, animated: true, completion: nil)
    }
    
    func handle(route: HistoryScreenRoute) {
        switch route {
        case .someScreen: self.showSomeScreen()
        }
    }
    
}

extension HistoryScreenRouter {
    
    fileprivate func showSomeScreen() {
        // Show some screen
    }
    
}
