//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var storyText: UILabel!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    
    var storyBrain = StoryBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    
    @IBAction func choicePressed(_ sender: UIButton) {
        
        storyBrain.nextStory(choice: sender.currentTitle!)
        
        updateUI()
    }
    
    func updateUI(){
        
        storyText.text =  storyBrain.getStoryTitle()
        buttonOne.setTitle(storyBrain.getChoice1(), for: .normal)
        buttonTwo.setTitle(storyBrain.getChoice2(), for: .normal)
    }
    
}

