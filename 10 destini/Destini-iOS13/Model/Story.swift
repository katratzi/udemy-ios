//
//  Sotry.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct Story {
    var title: String
    var choice1 : String
    var choice2 : String
    var nextStory1 : Int
    var nextStory2 : Int
    
    init(title: String, choice1: String, choice1Destination: Int, choice2: String, choice2Destination: Int) {
        self.title = title
        self.choice1 = choice1
        self.choice2 = choice2
        self.nextStory1 = choice1Destination
        self.nextStory2 = choice2Destination
    }
    
}
