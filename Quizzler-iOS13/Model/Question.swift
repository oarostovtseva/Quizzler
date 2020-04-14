//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Olena Rostovtseva on 07.04.2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

struct Question {
    let question: String
    let answers: Array<String>
    let correctAnswer: String
    
    init(q: String, a: Array<String>, correctAnswer:String) {
        self.question = q
        self.answers = a
        self.correctAnswer = correctAnswer
    }
}
