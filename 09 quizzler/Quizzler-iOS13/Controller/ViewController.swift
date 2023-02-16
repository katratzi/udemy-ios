//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    var quizBrain = QuizBrain()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }


    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle! // True, False
        let isCorrect = quizBrain.checkAnswer(userAnswer)

        sender.backgroundColor = isCorrect ? UIColor.green : UIColor.red
        
        quizBrain.nextQuestion()
    
        // Wait to show next question
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    @objc func updateUI(){
        questionLabel.text = quizBrain.getQuestionText();
        oneButton.setTitle(quizBrain.getAnswerText(0), for: .normal)
        twoButton.setTitle(quizBrain.getAnswerText(1), for: .normal)
        threeButton.setTitle(quizBrain.getAnswerText(2), for: .normal)
        progressBar.progress = quizBrain.getProgress()
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        oneButton.backgroundColor = UIColor.clear;
        twoButton.backgroundColor = UIColor.clear;
        threeButton.backgroundColor = UIColor.clear;
        
    }
}

