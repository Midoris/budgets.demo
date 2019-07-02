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
    @IBOutlet weak var typeButton: UIButton!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var amountTextField: UITextField!
    
    var preselectedFund: Fund?
    var budget: Budget?
    
    var selectedName: String? {
        didSet {
            guard let _selectedName = selectedName else { return }
            self.nameButton.setTitle("\(_selectedName) ▾", for: .normal)
        }
    }
    var selectedType: FundType? {
        didSet {
            guard let _selectedType = selectedType else { return }
            self.typeButton.setTitle("▾ \(_selectedType.name)", for: .normal)
                
        }
    }
    var selectedAmount: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetup()

    }
    
    private func initialViewSetup() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped))
        self.amountTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        guard let _budget = self.budget else { return }
        
        self.amountTextField.placeholder = _budget.currencyCode
        self.amountTextField.becomeFirstResponder()
        self.nameLabel.textColor = UIColor.textGrey
        self.nameButton.tintColor = UIColor.textGrey
        self.nameButton.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        self.typeLabel.textColor = UIColor.textGrey
        self.typeButton.tintColor = UIColor.textGrey
        self.typeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        
        guard let _selectedFund = preselectedFund else {
            self.typeButton.setTitle("▾ select", for: .normal)
            self.nameButton.setTitle("enter name ▾", for: .normal)
            self.navigationItem.title = "Add Fund"
            return
        }
        
        self.navigationItem.title = "Edit Fund"
        self.selectedName = _selectedFund.name
        self.selectedType = _selectedFund.type
        self.amountTextField.text = String(_selectedFund.amount)

    }
    
    @IBAction func nameButtonTapped(_ sender: UIButton) {
        self.amountTextField.resignFirstResponder()

        let alert = UIAlertController(title: "Fund Name", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = self.selectedName ?? ""
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            guard let textField = alert?.textFields?[0],
                  let newName = textField.text,
                  newName != ""
                else { return }
            self.selectedName = newName
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func typeButtonTapped(_ sender: Any) {
        self.amountTextField.resignFirstResponder()
        
        
        guard let controller = SelectFundTypeVC.instance else { return }
        controller.delegate = self
        controller.preselectedFundType = self.selectedType
        let navController = UINavigationController(rootViewController: controller)
        self.present(navController, animated: true, completion: nil)
        
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        
        guard let selectedValue = Double(textField.text ?? "") else { return }
        let rounded = Double(round(100*selectedValue)/100)
        self.selectedAmount = rounded
    }
    
    @objc private func saveButtonTapped() {
        // TODO Pass back new Fund
        guard
            let fundName = self.selectedName,
            let fundType = self.selectedType,
            let fundAmount = self.selectedAmount
            else {
                // TODO: show some error message
                return
        }
        
        if let _preselectedFund = self.preselectedFund {
            let newFund = Fund(
                name: fundName,
                amount: fundAmount,
                type: fundType,
                entries: _preselectedFund.entries
            )
            // TODO: Save changes
            
        } else {
            let newFund = Fund(
                name: fundName,
                amount: fundAmount,
                type: fundType,
                entries: []
            )
            // TODO: Save changes
        }
        
        self.navigationController?.popViewController(animated: true)
    }

}

extension AddFundViewController {
    static var instance: AddFundViewController? {
         guard let controller = UIStoryboard(name: "BudgetDetailsScreen", bundle: nil).instantiateViewController(withIdentifier: String(describing: AddFundViewController.self)) as? AddFundViewController else { return nil }
        return controller
    }
}

extension AddFundViewController: SelectFundTypeDelegate {
    
    func typeSelected(type: FundType) {
        self.selectedType = type
    }
    
}
