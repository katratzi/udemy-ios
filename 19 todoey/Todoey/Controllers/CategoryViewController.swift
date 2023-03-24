//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Richard Clifford on 09/03/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryViewController: SwipeTableViewController {

    let realm = try! Realm()
    
    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }

    //MARK: - TableView Datasource methods
    
    // how many rows
    override func tableView(_ tableView:  UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added"
        
        return cell
    }
    
    //MARK: - Data Manipulation methods save/load
    
    func save(category: Category)
    {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print(" Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    // provide a default value if no request is passed
    func loadCategories()
    {
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    //MARK: - Delete Data from swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let selectedCategory = self.categoryArray?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(selectedCategory)
                }
            } catch {
                print("error deleting category, \(error)")
            }
            
        }
    }
    
    //MARK: - Add new categories
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // scope outside of the action buttons
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            // what will happen once the use clicks the add button
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.text = "Create new category"
            textField = alertTextField
        }
        
        // show the alert
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
    //MARK: - TableView delegate methods
    // i.e. what happends when we click on a category
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // could also check segue identifier if we had miltiple paths
        
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow
        {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
        
    }
    
}



