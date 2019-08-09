//
//  BalanceEntryViewController.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 10.07.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class BalanceEntryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
    }
    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
   

}

extension BalanceEntryViewController {
    static var instance: BalanceEntryViewController? {
        guard let controller = UIStoryboard(name: "BalanceScreen", bundle: nil).instantiateViewController(withIdentifier: String(describing: BalanceEntryViewController.self)) as? BalanceEntryViewController else { return nil }
        return controller
    }
}
