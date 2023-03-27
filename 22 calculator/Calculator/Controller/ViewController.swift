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
            let calculator = CalculatorLogic(number: displayValue)
            guard let result = calculator.calculate(symbol: calcMethod) else {
                fatalError("Result of calculation is nil")
            }
            displayValue = result
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

