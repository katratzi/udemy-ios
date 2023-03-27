//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Richard Clifford on 27/03/2023.
//  Copyright © 2023 London App Brewery. All rights reserved.
//

import Foundation

class CalculatorLogic {
    
    var number : Double = 0.0
    
    init(number: Double){
        self.number = number
    }
    
    func calculate(symbol: String) -> Double? {
        if symbol == "+/-"{
            return number * -1
        }
        else if symbol == "AC"{
            return 0.0
        }
        else if symbol == "%"{
            return number / 100.0
        }
        
        return nil
    }
}
