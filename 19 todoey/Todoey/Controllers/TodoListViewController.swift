//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {
    
    var todoItems : Results<Item>?
    let realm = try! Realm()
    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        
        // print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        tableView.separatorStyle = .none
        
    }
    
    // called after view did load, just before it's seen
    override func viewWillAppear(_ animated: Bool) {
        
        if let colorHex = selectedCategory?.color {
            
            title = selectedCategory!.name

            guard let navBar = navigationController?.navigationBar else {
                fatalError("Navigation controller does not exist")
            }
            
            if let navBarColor = UIColor(hexString: colorHex)
            {
                navBar.backgroundColor = navBarColor
                searchBar.barTintColor = navBarColor
                navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
                navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:  ContrastColorOf(navBarColor, returnFlat: true)]
            }
        }
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView:  UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // call the super class to create the swipe cell itself
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        // now handle tap to toggle done
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
            
            // set color
            let percent = CGFloat(indexPath.row) /  CGFloat(todoItems!.count)
            if let color = UIColor(hexString: selectedCategory!.color)?.darken(byPercentage: percent)
            {
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            }
        } else {
            cell.textLabel?.text = "No items added"
        }
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // add/remove checkmark
        
        if let item = todoItems?[indexPath.row] {
            
            do {
                try realm.write {
                    item.done = !item.done
//                    realm.delete(item)
                }
            } catch {
                print("error saving toggling, \(error)")
            }
        }
        
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
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving items, \(error)")
                }
            }
            
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

    
    // provide a default value if no request is passed
    func loadItems()
    {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
    
    //MARK: - Delete Data from swipe
    
    override func updateModel(at indexPath: IndexPath) {
        
        if let item = self.todoItems?[indexPath.row] {
            
            do {
                try self.realm.write {
                    self.realm.delete(item)
                }
            } catch {
                print("error deleting item, \(error)")
            }
        }
        
    }
    
    
}

//MARK: - Search Bar Methods

// Extend to handle the search bar
extension TodoListViewController : UISearchBarDelegate
{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        // search bar has been cleared
        if(searchBar.text?.count == 0)
        {
            loadItems()

            DispatchQueue.main.async {
                // this clears the keyboard and the text cursor, basically unselect
                searchBar.resignFirstResponder()
            }

        }
    }
}

