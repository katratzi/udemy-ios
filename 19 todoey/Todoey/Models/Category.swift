//
//  Category.swift
//  Todoey
//
//  Created by Richard Clifford on 24/03/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    @objc dynamic var color : String = "#FFFFFF"
    let items = List<Item>()
}
