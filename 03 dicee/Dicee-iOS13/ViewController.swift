//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // IBOutlet allows me to reference a UI element
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    var leftDiceNumber = 1;
    var rightDiceNumber = 1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // #imageLiteral(
        // WHO.WHAT = VALUE
        diceImageView1.image = #imageLiteral(resourceName: "DiceTwo")
        diceImageView1.alpha = 0.5
        
        diceImageView2.image = #imageLiteral(resourceName: "DiceTwo")
        diceImageView2.alpha = 0.5
    
    }


    @IBAction func rollButtonPressed(_ sender: UIButton) {
        print("button got pressed")
        // diceImageView1.image = #imageLiteral(resourceName: "DiceFour")
        // diceImageView2.image = #imageLiteral(resourceName: "DiceFour")
        diceImageView1.image =  [#imageLiteral(resourceName: "DiceOne"), #imageLiteral(resourceName: "DiceTwo"), #imageLiteral(resourceName: "DiceThree"), #imageLiteral(resourceName: "DiceFour"), #imageLiteral(resourceName: "DiceFive"), #imageLiteral(resourceName: "DiceSix")][leftDiceNumber]
        diceImageView2.image =  [#imageLiteral(resourceName: "DiceOne"), #imageLiteral(resourceName: "DiceTwo"), #imageLiteral(resourceName: "DiceThree"), #imageLiteral(resourceName: "DiceFour"), #imageLiteral(resourceName: "DiceFive"), #imageLiteral(resourceName: "DiceSix")][rightDiceNumber]
        
        // can add in code to execute with \()
        print("left is \(leftDiceNumber)")
        leftDiceNumber = leftDiceNumber + 1
        rightDiceNumber = rightDiceNumber + 1
    }
}

