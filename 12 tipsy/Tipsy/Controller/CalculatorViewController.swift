//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var tenButton: UIButton!
    @IBOutlet weak var twentyButton: UIButton!
    
    @IBOutlet weak var splitCountLabel: UILabel!
    
    var tipBrain = TipBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // useful defaults
        tipBrain.split = 2
        tipBrain.tip = 0.1
    }
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        // set tip amount
        switch sender.currentTitle
        {
        case "0%":
            tipBrain.tip = 0.0
        case "10%":
            tipBrain.tip = 0.1
        case "20%":
            tipBrain.tip = 0.2
        default:
            tipBrain.tip = 0.0
        }
        
        // set correct selection
        zeroButton.isSelected = zeroButton == sender
        tenButton.isSelected = tenButton == sender
        twentyButton.isSelected = twentyButton == sender
        
        print(tipBrain.tip!)
        
        stopBillEditing()
        billTextField.endEditing(true)
        _ = tipBrain.calculateTip()
    }
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        print(sender.value)
        let splitInt = Int(sender.value)
        tipBrain.setSplit(splitAmount: splitInt)
        splitCountLabel.text = "\(splitInt)"
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "gotoResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {

        // showing results
        if(segue.identifier == "gotoResults"){
            var resultsView = segue.destination as! ResultViewController
            resultsView.setting  = tipBrain.getSettings()
            resultsView.total = tipBrain.getSplitTotal()
        }
    }
    
    
    
    func stopBillEditing(){
        billTextField.endEditing(true)
        tipBrain.setBill(billAmount: Float(billTextField.text ?? "0"))
    }
    
}

