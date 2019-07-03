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
    var fundTypes: [FundType] = [
        FundType.income,
        FundType.expense,
        FundType.saving,
        FundType.recurring
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.loadCustomFundTypes()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(cancelButtonTapped))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonTapped))
        
        self.navigationItem.title = "Select Fund Type"

    }
    
    private func loadCustomFundTypes() {
        let customTypes = UserDefaultsManager.customFundTypes
        self.fundTypes.append(contentsOf: customTypes)
    }
    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func addButtonTapped() {
        
        let alert = UIAlertController(title: "Fund Type", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.autocapitalizationType = .words
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
        saveNewTypeToUserDefaluts(newType: newType)
        self.fundTypes.append(newType)
        self.tableView.reloadData()
    }
    
    private func removeType(typeToRemove: FundType) {
        removeFromUserDefaults(typeToRemove: typeToRemove)
        let filteredTypes = self.fundTypes.filter { $0 != typeToRemove }
        self.fundTypes = filteredTypes
    }
    
    private func saveNewTypeToUserDefaluts(newType: FundType) {
        var customTypes = UserDefaultsManager.customFundTypes
        customTypes.append(newType)
        UserDefaultsManager.customFundTypes = customTypes
    }
    
    private func removeFromUserDefaults(typeToRemove: FundType) {
        let customTypes = UserDefaultsManager.customFundTypes
        let typesToSave = customTypes.filter { $0 != typeToRemove }
        UserDefaultsManager.customFundTypes = typesToSave
    }

}

extension SelectFundTypeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fundTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let fundType = self.fundTypes[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        let cell: UITableViewCell
        
        switch fundType {
        case .custom:
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
            cell.detailTextLabel?.text = "Custom Type"
        default:
            cell = UITableViewCell()
        }

        cell.textLabel?.text = fundType.name
        cell.accessoryType = fundType == preselectedFundType ? .checkmark : .none
        
        return cell
    }
    
}

extension SelectFundTypeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedType = self.fundTypes[safe: indexPath.row] else {
            return
        }
        delegate?.typeSelected(type: selectedType)
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard
            let typeToRemove = self.fundTypes[safe: indexPath.row]
            else { return }
        
        switch typeToRemove {
        case .custom:
            if editingStyle == .delete {
                self.removeType(typeToRemove: typeToRemove)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default: break
        }

    }
}


extension SelectFundTypeVC {
    static var instance: SelectFundTypeVC? {
        guard let controller = UIStoryboard(name: "BudgetDetailsScreen", bundle: nil).instantiateViewController(withIdentifier: String(describing: SelectFundTypeVC.self)) as? SelectFundTypeVC else { return nil }
        return controller
    }
}
