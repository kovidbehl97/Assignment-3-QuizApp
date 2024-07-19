//
//  AddQuestionViewController.swift
//  QuizApp
//
//  Created by Kovid Behl on 2024-07-18.
//

import UIKit

class AddQuestionViewController: UIViewController {
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var correctAnswerTextField: UITextField!
    @IBOutlet weak var incorrectAnswer1TextField: UITextField!
    @IBOutlet weak var incorrectAnswer2TextField: UITextField!
    @IBOutlet weak var incorrectAnswer3TextField: UITextField!

    weak var delegate: QuestionBuilderDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func saveQuestion(_ sender: UIButton) {
        guard let questionText = questionTextField.text,
              let correctAnswer = correctAnswerTextField.text,
              let incorrectAnswer1 = incorrectAnswer1TextField.text,
              let incorrectAnswer2 = incorrectAnswer2TextField.text,
              let incorrectAnswer3 = incorrectAnswer3TextField.text else {
            // Handle empty fields
            return
        }

        let newQuestion = Question(text: questionText, correctAnswer: correctAnswer, incorrectAnswers: [incorrectAnswer1, incorrectAnswer2, incorrectAnswer3])
        delegate?.didSaveQuestion(newQuestion)
        navigationController?.popViewController(animated: true)
    }
}
