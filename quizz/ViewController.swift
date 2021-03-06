//
//  ViewController.swift
//  quizz
//
//  Created by SD on 21/03/2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

//    let questionOne = QuizQuestion(question:  "Reuzel is gesmolten?", answer: "Vet")
//    let questionTwo = QuizQuestion(question:  "De man die een doel verdedigt noemen we een?", answer: "Keeper")
    
    var quizQuestions: [QuizQuestion] = []
    var categoryQuestions:[QuizQuestion] = []
    var currentQuestion = 0
    var answerIsCorrect = false
    var answerCount = 0
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var green: UIButton!
    @IBOutlet weak var blue: UIButton!
    @IBOutlet weak var yellow: UIButton!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var red: UIButton!
    @IBOutlet weak var orange: UIButton!
    @IBOutlet weak var HOME: UIButton!
    @IBOutlet weak var AnswerCount: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        answerTextField.delegate = self
        getLocalQuizData()
    }
    
    

    func updateQuestion() {
        questionLabel.text = categoryQuestions[currentQuestion].question
        answerTextField.text=""
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        currentQuestion += 1
        answerLabel.text=""
        
        if currentQuestion >= categoryQuestions.count{
            currentQuestion = 0
        }
        updateQuestion()
        
    }

    
    @IBAction func red(_ sender: Any) {
        categoryQuestions = quizQuestions.filter { $0.category == .red }
        green.isHidden = true
        blue.isHidden = true
        orange.isHidden = true
        yellow.isHidden = true
        updateQuestion()
    }
    
    @IBAction func blue(_ sender: Any) {
        categoryQuestions = quizQuestions.filter { $0.category == .blue }

        red.isHidden = true
        green.isHidden = true
        yellow.isHidden = true
        orange.isHidden = true
        updateQuestion()
    }
    
    @IBAction func green(_ sender: Any) {
        categoryQuestions = quizQuestions.filter { $0.category == .green }

        red.isHidden = true
        blue.isHidden = true
        yellow.isHidden = true
        orange.isHidden = true
        updateQuestion()
    }
    
    @IBAction func yellow(_ sender: Any) {
        categoryQuestions = quizQuestions.filter { $0.category == .yellow}

        red.isHidden = true
        blue.isHidden = true
        green.isHidden = true
        orange.isHidden = true
        updateQuestion()
    }
    @IBAction func orange(_ sender: Any) {
        categoryQuestions = quizQuestions.filter { $0.category == .orange}

        red.isHidden = true
        blue.isHidden = true
        green.isHidden = true
        yellow.isHidden = true
        updateQuestion()
    }
    
    
    @IBAction func HOME(_ sender: Any) {
        questionLabel.text = "Selecteer een categorie"
        answerLabel.text = ""
        currentQuestion = 0
        answerTextField.text = ""
        red.isHidden = false
        blue.isHidden = false
        green.isHidden = false
        yellow.isHidden = false
        orange.isHidden = false
    }
    
    func checkAnswer(answer: String) {
        if answer.lowercased() == quizQuestions[currentQuestion].answer.lowercased() {
            answerLabel.text = "Goed!"
            answerCount += 1
            AnswerCount.text = String(answerCount)
        } else {
            answerLabel.text = "Fout!, antwoord was: " + categoryQuestions[currentQuestion].answer
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        if let answer = textField.text {
            checkAnswer(answer: answer)
        }
        
        textField.resignFirstResponder()

        return true
    }

    

  
    
    // MARK: - JSON Functions
    
    func getLocalQuizData() {
        // Call readLocalFile function with the name of the local file (localQuizData)
        if let localData = self.readLocalFile(forName: "localQuizData") {
            // File exists, now parse 'localData' with the parse function
            self.parse(jsonData: localData)
        }
    }

    // Read local file

    private func readLocalFile(forName name: String) -> Data? {
        do {
            // Check if file exists in application bundle, then try to convert it to a string, if that works return that
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error) // Something went wrong, show an alert
        }
        
        return nil
    }

    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode([QuizQuestion].self,
                                                       from: jsonData)
            /*
            print("Question: ", decodedData[0].question)
            print("Answer: ", decodedData[0].answer)
            print("===================================")
            */
            
            self.quizQuestions = decodedData
        } catch {
            print("decode error")
        }
    }
    
}


