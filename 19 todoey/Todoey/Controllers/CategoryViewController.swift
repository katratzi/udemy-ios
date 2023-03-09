//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Richard Clifford on 09/03/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }

    //MARK: - TableView Datasource methods
    
    // how many rows
    override func tableView(_ tableView:  UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    //MARK: - Data Manipulation methods save/load
    
    func saveCategories()
    {
        do {
            try context.save()
        } catch {
            print(" Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    // provide a default value if no request is passed
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest())
    {
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    //MARK: - Add new categories
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // scope outside of the action buttons
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            // what will happen once the use clicks the add button
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            
            self.saveCategories()
            
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
    
    
}
