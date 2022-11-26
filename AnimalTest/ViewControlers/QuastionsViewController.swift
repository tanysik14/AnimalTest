//
//  QuastionsViewController.swift
//  AnimalTest
//
//  Created by Tatsiana Pauliukova on 24.11.22.
//

import UIKit

class QuastionsViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var questionProgressView: UIProgressView!
    
    @IBOutlet var singleStakeView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multipleisLabels: [UILabel]!
    @IBOutlet var multipleSwitchs: [UISwitch]!
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet var rangedSlider: UISlider! {
        didSet {
            let answerCount = Float(currentAnswers.count - 1)
            
            rangedSlider.maximumValue = answerCount
            rangedSlider.value = answerCount / 2
        }
    }

    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var answersChosen: [Answer] = []
    
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func singleButtonAnswerPressed(_ sender: UIButton) {
        guard let currentIndex = singleButtons.firstIndex(of: sender) else { return }
        
        let currentAnswer = currentAnswers[currentIndex]
        answersChosen.append(currentAnswer)
        
        nextQuestion()
    }
    
    @IBAction func multipleButtonAnswerPressed() {
        for (multipleSwitch, answer) in zip(multipleSwitchs, currentAnswers) {
            if multipleSwitch.isOn {
                answersChosen.append(answer)
            }
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedButtonAnswerPressed() {
        let index = lrintf(rangedSlider.value)
        
        answersChosen.append(currentAnswers[index])
        
        
        
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let destination = segue.destination as? ResultViewController else { return }
            destination.pollResults = currentAnswers
          
          
        }
        print(currentAnswers)
        nextQuestion()
    }
    }
    
    // MARK: - Private Methods
    extension QuastionsViewController {
        private func updateUI() {
            for stackView in [singleStakeView, multipleStackView, rangedStackView] {
                stackView?.isHidden = true
            }
            
            let currentQuestion = questions[questionIndex]
            questionLabel.text = currentQuestion.title
            
            let tottalProgress = Float(questionIndex) / Float(questions.count)
            questionProgressView.setProgress(tottalProgress, animated: true)
            
            title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
            
            showCurrentAnswers(for: currentQuestion.type)
        }
        
        private func showCurrentAnswers(for type: ResponseType) {
            switch type {
            case .single:
                showSingleStackView(with: currentAnswers)
            case .multiple:
                showMultipleStackView(with: currentAnswers)
            case .ranger:
                showRengedStackView(with: currentAnswers)
            }
        }
        
        private func showSingleStackView(with answers: [Answer]) {
            singleStakeView.isHidden = false
            
            for (button, answer) in zip(singleButtons, answers) {
                button.setTitle(answer.title, for: .normal)
            }
        }
        
        private func showMultipleStackView(with answers: [Answer]) {
            multipleStackView.isHidden = false
            
            for (label, answer) in zip(multipleisLabels, answers) {
                label.text = answer.title
            }
        }
        
        private func showRengedStackView(with answers: [Answer]) {
            rangedStackView.isHidden = false
            
            rangedLabels.first?.text = answers.first?.title
            rangedLabels.last?.text = answers.last?.title
        }
        
        private func nextQuestion() {
            questionIndex += 1
            
            if questionIndex < questions.count {
                updateUI()
                return
            }
            
            performSegue(withIdentifier: "showResult", sender: nil)
        }
    }


