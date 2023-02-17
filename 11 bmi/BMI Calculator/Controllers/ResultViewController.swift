//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Richard Clifford on 17/02/2023.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var bmiValue : String?
    
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiLabel.text = bmiValue
    }
    

    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

}
