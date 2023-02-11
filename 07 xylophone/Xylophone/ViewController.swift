//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func keyPressed(_ sender: UIButton) {
        print(sender.currentTitle!)
        playSound(chime: sender.currentTitle)
        translucentButton(xyloButton: sender)
    }
    
    func playSound(chime: String?) {
        let url = Bundle.main.url(forResource: chime, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
    
    func translucentButton(xyloButton: UIButton){
        print(xyloButton.backgroundColor!)
        xyloButton.alpha = 0.75
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            xyloButton.alpha = 1.0
        }
    }
}

