//
//  TipBrain.swift
//  Tipsy
//
//  Created by Richard Clifford on 17/02/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct TipBrain {
    
    var tip : Float?
    var bill : Float?
    var split : Int?
    
    mutating func setTip(tipAmount: Float){
        tip = tipAmount
    }
    
    mutating func setBill(billAmount: Float?) {
        bill = billAmount ?? 0.0
    }
    
    mutating func setSplit(splitAmount: Int){
        split = splitAmount
    }
    
    func calculateTip() -> Float {
        if tip != nil && bill != nil && split != nil{
            let finalTip = (bill! * tip!) / Float(split!)
            print(finalTip)
            return finalTip
        }
        else {
            return 0.0
        }
    }
    
    func getSettings() -> String {
        let splitString = String(split ?? 2)
        print(splitString)
        let tipString = String(format: "%.0f", tip! * 100)
        print(tipString)
        return "Split between \(splitString) people, with \(tipString)% tip"
    }
    
    func getSplitTotal() -> String {
        return String(String(format: "%.2f", calculateTip()))
    }
}
