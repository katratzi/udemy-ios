//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike", "Buy Milk", "Destory Demigod"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView:  UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // add/remove checkmark
        if let cell = tableView.cellForRow(at: indexPath)
        {
            if cell.accessoryType == .checkmark
            {
                cell.accessoryType = .none
            }
            else
            {
                cell.accessoryType = .checkmark
            }
        }
    }
    
    //MARK - Add Todo List items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        // scope outside of the action buttons
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // what will happen once the use clicks the add button
            print("Success" + textField.text!)
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.text = "Create new item"
            textField = alertTextField
        }
        
        // show the alert
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
}

