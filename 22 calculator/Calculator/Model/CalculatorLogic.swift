//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Richard Clifford on 27/03/2023.
//  Copyright © 2023 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    
    private var number : Double?
    
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    mutating func setNumber(_ number: Double){
        self.number = number
    }
    
    mutating func calculate(symbol: String) -> Double? {
        
        if let n = number {
            if symbol == "+/-" {
                return n * -1
            }
            else if symbol == "AC" {
                return 0.0
            }
            else if symbol == "%" {
                return n / 100.0
            } else if symbol == "=" {
                return performTwoNumberCalculation(n2: n)
            } else {
                // should a symbol like +, -,
                intermediateCalculation = (n1: n, calcMethod: symbol)
            }
        }
        
        return nil
    }
    
    private func performTwoNumberCalculation(n2: Double) -> Double?
    {
        if let n1 = intermediateCalculation?.n1, let operation = intermediateCalculation?.calcMethod
        {
            switch(operation) {
            case("+"):
                return n1 + n2
            case("-"):
                return n1 - n2
            case("×"):
                return n1 * n2
            case("÷"):
                return n1 / n2
            default:
                fatalError("No matching operation case")
            }
        }
        
        return nil
    }
}
