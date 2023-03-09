//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Richard Clifford on 09/03/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: - TableView Datasource methods
    
    //MARK: - Data Manipulation methods save/load
    
    //MARK: - Add new categories
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    
    //MARK: - TableView delegate methods
    // i.e. what happends when we click on a category
    
    
}
