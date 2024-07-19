//
//  QuestionBankViewController.swift
//  QuizApp
//
//  Created by Kovid Behl on 2024-07-18.
//

import UIKit

class QuestionBankViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    var questions: [Question] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        questions = QuestionManager.shared.questions
    }

    @IBAction func addQuestion(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addQuestion", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath)
            cell.textLabel?.text = questions[indexPath.row].text
            return cell
        }
    
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "updateQuestion", sender: questions[indexPath.row])
    }
   

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addQuestion", let destinationVC = segue.destination as? AddQuestionViewController {
            destinationVC.delegate = self
        } else if segue.identifier == "updateQuestion", let destinationVC = segue.destination as? UpdateQuestionViewController, let question = sender as? Question {
            destinationVC.question = question
            destinationVC.delegate = self
        }
    }
    
}

extension QuestionBankViewController: QuestionBuilderDelegate {
    func didSaveQuestion(_ question: Question) {
        QuestionManager.shared.questions.append(question)
        questions = QuestionManager.shared.questions
        tableView.reloadData()
    }

    func didUpdateQuestion(_ question: Question) {
        if let index = QuestionManager.shared.questions.firstIndex(where: { $0.id == question.id }) {
               QuestionManager.shared.questions[index] = question
            questions = QuestionManager.shared.questions
            tableView.reloadData()
        }
    }
}
