//
//  SelectFundTypeVC.swift
//  Budgets
//
//  Created by IEVGENII IABLONSKYI on 02.07.19.
//  Copyright © 2019 IEVGENII IABLONSKYI. All rights reserved.
//

import UIKit

protocol SelectFundTypeDelegate {
    func typeSelected(type: FundType)
}

class SelectFundTypeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var delegate: SelectFundTypeDelegate?
    var preselectedFundType: FundType?
    var ds: [FundType] = [FundType.income, FundType.expense, FundType.saving, FundType.recurring]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(cancelButtonTapped))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonTapped))
        
        self.navigationItem.title = "Select Fund Type"

    }
    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func addButtonTapped() {
        
        let alert = UIAlertController(title: "Fund Type", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            
            
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            guard let textField = alert?.textFields?[0],
             let newTypeName = textField.text,
             newTypeName != "" else {
                return
            }
            self.saveNewType(typeName: newTypeName)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func saveNewType(typeName: String) {
        let newType = FundType.custom(typeName)
        self.ds.append(newType)
        self.tableView.reloadData()
    }

}

extension SelectFundTypeVC: UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        guard let fundType = self.ds[safe: indexPath.row] else {
            return cell
        }
        cell.textLabel?.text = fundType.name
        cell.accessoryType = fundType == preselectedFundType ? .checkmark : .none
        
        return cell
    }
    
}

extension SelectFundTypeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedType = self.ds[safe: indexPath.row] else {
            return
        }
        delegate?.typeSelected(type: selectedType)
        self.dismiss(animated: true, completion: nil)
    }
}


extension SelectFundTypeVC {
    static var instance: SelectFundTypeVC? {
        guard let controller = UIStoryboard(name: "BudgetDetailsScreen", bundle: nil).instantiateViewController(withIdentifier: String(describing: SelectFundTypeVC.self)) as? SelectFundTypeVC else { return nil }
        return controller
    }
}
