//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var eggProgress: UIProgressView!
    @IBOutlet var eggTitle: UILabel?
    
    // dictionary of times
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 6]
    // var dict : [String : Int] : ["Soft": 5, "Medium": 7, "Hard": 12] for explicit typing
    var timer : Timer?
    var hardness : String = "Soft"
    var secondsRemaining : Int = 10
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        hardness = sender.currentTitle!
        
        print("Start \(eggTimes[hardness]!)")
        startTimer(seconds: eggTimes[hardness]!)
        eggProgress.progress = 0;
    }
    
    func startTimer(seconds : Int) {
        
        // start a new count
        secondsRemaining = seconds
        print("Countdown started...\(secondsRemaining)")
        
        // stop if we have one started
        if timer != nil
        {
            timer!.invalidate()
        }
        
        // create a timer to fire every second
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.updateCounting()
        })
    }

    func updateCounting(){
        print("\(secondsRemaining) seconds.")
        secondsRemaining-=1
        if(secondsRemaining < 0)
        {
            timer?.invalidate()
            // change title
            eggTitle!.text = "Done"
            eggProgress.progress = 1
        }
        
        eggProgress.progress = 1.0 -  Float(secondsRemaining) / Float(eggTimes[hardness]!)
    }
    
}
