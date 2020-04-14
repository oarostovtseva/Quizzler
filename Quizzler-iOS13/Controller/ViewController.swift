//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Olena Rostovtseva on 07.04.2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var option1Button: UIButton!
    @IBOutlet var option2Button: UIButton!
    @IBOutlet var option3Button: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    
    let quizManager = QuizManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        checkAnswer(button: sender)
        updateQuestion()
    }
    
    func checkAnswer(button: UIButton) {
        if quizManager.isAnswerRight(button.currentTitle!) {
            button.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        } else {
            button.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
    }
    
    func updateQuestion() {
        if quizManager.nextQuestion() < quizManager.getQuestionCount() {
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                self.updateUI()
            }
        } else {
            let alert = UIAlertController(title: "Congrats!", message: "You are done with a score \(quizManager.getScore())", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.quizManager.gotoFirstQuestion()
                self.updateUI()
                self.updateProgressBar()
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateUI() {
        questionLabel.text = quizManager.getQuestionText()
        
        let answerOptions = quizManager.getAnswersOptions()
        option1Button.setTitle(answerOptions[0], for: .normal)
        option2Button.setTitle(answerOptions[1], for: .normal)
        option3Button.setTitle(answerOptions[2], for: .normal)
        
        option1Button.backgroundColor = UIColor.clear
        option2Button.backgroundColor = UIColor.clear
        option3Button.backgroundColor = UIColor.clear
        
        scoreLabel.text = "Score: \(quizManager.getScore())"
        updateProgressBar()
    }
    
    func updateProgressBar() {
        if quizManager.isFirstQuestion() {
            progressView.progress = Float(1) / Float(quizManager.getQuestionCount())
        } else if quizManager.isLastQuestion() {
            progressView.progress = 1
        } else {
            progressView.progress += Float(1) / Float(quizManager.getQuestionCount())
        }
    }
}
