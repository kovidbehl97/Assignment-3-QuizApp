//
//  Question.swift
//  QuizApp
//
//  Created by Kovid Behl on 2024-07-18.
//

import Foundation

struct Question {
    let id: UUID
    var text: String
    var correctAnswer: String
    var incorrectAnswers: [String]

    init(text: String, correctAnswer: String, incorrectAnswers: [String]) {
        self.id = UUID()
        self.text = text
        self.correctAnswer = correctAnswer
        self.incorrectAnswers = incorrectAnswers
    }
}



class QuestionManager {
    static let shared = QuestionManager()
    private init() {}

    var questions: [Question] = []
}
