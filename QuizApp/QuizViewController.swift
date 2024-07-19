//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Kovid Behl on 2024-07-18.
//

import UIKit

class QuizViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!

    var questions: [Question] = []
    var currentQuestionIndex: Int = 0
    var score: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        if questions.isEmpty {
                print("No questions available")
                return
            }
        showQuestion(at: currentQuestionIndex)
        updateNavigationButtons()
    }

   
    func showQuestion(at index: Int) {
        guard index >= 0 && index < questions.count else {
            print("Index out of range")
            return
        }
        
        let question = questions[index]
        questionLabel.text = question.text
        let allAnswers = question.incorrectAnswers + [question.correctAnswer]
        let shuffledAnswers = allAnswers.shuffled()

        answerButton1.setTitle(shuffledAnswers[0], for: .normal)
        answerButton2.setTitle(shuffledAnswers[1], for: .normal)
        answerButton3.setTitle(shuffledAnswers[2], for: .normal)
        answerButton4.setTitle(shuffledAnswers[3], for: .normal)

        progressBar.progress = Float(index) / Float(questions.count)
        updateNavigationButtons()
    }


    @IBAction func answerSelected(_ sender: UIButton) {
        guard currentQuestionIndex >= 0 && currentQuestionIndex < questions.count else {
            print("Current question index out of range")
            return
        }

        let selectedAnswer = sender.title(for: .normal)
        let correctAnswer = questions[currentQuestionIndex].correctAnswer

        print("Selected Answer: \(selectedAnswer ?? "None")")
        print("Correct Answer: \(correctAnswer)")

        if selectedAnswer == correctAnswer {
            print("Correct!")
            score += 1
        } else {
            print("Incorrect!")
        }

        currentQuestionIndex += 1
        if currentQuestionIndex < questions.count {
            showQuestion(at: currentQuestionIndex)
        } else {
            performSegue(withIdentifier: "showResult", sender: self)
        }
    }


    @IBAction func nextQuestion(_ sender: UIButton) {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            showQuestion(at: currentQuestionIndex)
        }
    }

    @IBAction func previousQuestion(_ sender: UIButton) {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
            showQuestion(at: currentQuestionIndex)
        }
    }

    func updateNavigationButtons() {
        previousButton.isEnabled = currentQuestionIndex > 0
        nextButton.isEnabled = currentQuestionIndex < questions.count - 1
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult", let destinationVC = segue.destination as? ResultViewController {
            destinationVC.score = score
            destinationVC.totalQuestions = questions.count
        }
    }
}
