//
//  AddFundViewController.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 12.02.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class AddFundViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetup()

    }
    
    private func initialViewSetup() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneButtonTapped))
    }
    
    @objc private func doneButtonTapped() {
        self.dismiss(animated: true, completion:   nil)
    }

}

extension AddFundViewController {
    static var instance: AddFundViewController? {
         guard let controller = UIStoryboard(name: "BudgetDetailsScreen", bundle: nil).instantiateViewController(withIdentifier: String(describing: AddFundViewController.self)) as? AddFundViewController else { return nil }
        return controller
    }
}
