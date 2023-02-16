//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var storyText: UILabel!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func choicePressed(_ sender: UIButton) {
        print(sender.currentTitle!)
    }
    
}

