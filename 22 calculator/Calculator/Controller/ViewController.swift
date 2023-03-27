//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var isFinishedTypingNumber : Bool = true
    
    private var calculator = CalculatorLogic( )
    
    override func viewDidLoad() {
        // tuple access with number
        let tuple1 = ("Rygel", 16)
        print(tuple1.0) // "Rygel"
        
        // tuple access with name
        let tuple2 = (name: "Angela", age: 12)
        print(tuple2.name)
        
        // tuple data type declaration
        let tuple3: (name: String, age: Int)
        tuple3 = (name: "Angela", age: 12)
        print(tuple3.name)
    }
    
    private var displayValue : Double {
        get {
            guard let currentDisplayValue = Double(displayLabel.text!) else {
                fatalError("Error converting displayLabel to double")
            }
            return currentDisplayValue
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        isFinishedTypingNumber = true
        
        
        if let calcMethod = sender.currentTitle {
            calculator.setNumber(displayValue)
            if let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            }
        }
         
    }
    
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
        if let numValue =  sender.currentTitle{
            
            if(isFinishedTypingNumber)
            {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                // add a decimal place but check if its an int
                if numValue == "."
                {
                    let isInt = floor(displayValue) == displayValue
                    if(!isInt){
                        return
                    }
                }
                displayLabel.text?.append(numValue)
            }
        }
    }
    
}

