//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem1 = Item()
        newItem1.title = "Find Mike"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Buy Shopping"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Global Supremacy"
        itemArray.append(newItem3)
        
        
//        if let items = userDefaults.array(forKey: "TodoListArray") as? [String] {
//            itemArray = items
//        }
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView:  UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // add/remove checkmark
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add Todo List items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        // scope outside of the action buttons
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // what will happen once the use clicks the add button
            print("Success" + textField.text!)
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.userDefaults.set(self.itemArray, forKey: "TodoListArray")
            
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

