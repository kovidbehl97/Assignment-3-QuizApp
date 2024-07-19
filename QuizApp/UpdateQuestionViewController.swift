//
//  UpdateQuestionViewController.swift
//  QuizApp
//
//  Created by Kovid Behl on 2024-07-18.
//

import UIKit

class UpdateQuestionViewController: UIViewController {
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var correctAnswerTextField: UITextField!
    @IBOutlet weak var incorrectAnswer1TextField: UITextField!
    @IBOutlet weak var incorrectAnswer2TextField: UITextField!
    @IBOutlet weak var incorrectAnswer3TextField: UITextField!

    var question: Question?
    weak var delegate: QuestionBuilderDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let question = question {
            questionTextField.text = question.text
            correctAnswerTextField.text = question.correctAnswer
            if question.incorrectAnswers.count > 2 {
                incorrectAnswer1TextField.text = question.incorrectAnswers[0]
                incorrectAnswer2TextField.text = question.incorrectAnswers[1]
                incorrectAnswer3TextField.text = question.incorrectAnswers[2]
            }
        }
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

        question?.text = questionText
        question?.correctAnswer = correctAnswer
        question?.incorrectAnswers = [incorrectAnswer1, incorrectAnswer2, incorrectAnswer3]
        delegate?.didUpdateQuestion(question!)
        navigationController?.popViewController(animated: true)
    }


}
