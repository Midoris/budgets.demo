//
//  AddFundViewController.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 12.02.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

class AddFundViewController: UIViewController {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    var selectedFunds: [Fund]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetup()

    }
    
    private func initialViewSetup() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneButtonTapped))
        
        guard let _selectedFunds = selectedFunds else { return }
        self.typeTextField.text = _selectedFunds.first?.type.rawValue
        self.nameTextField.text = _selectedFunds.first?.name
        self.amountTextField.text = String(_selectedFunds.map { $0.amount }.reduce(0, +))
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
