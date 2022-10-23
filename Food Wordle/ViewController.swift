//
//  ViewController.swift
//  Food Wordle
//
//  Created by Jube on 2022/10/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var guessLabels: [UILabel]!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var enterBtn: UIButton!
    @IBOutlet var keyBoardBtns: [UIButton]!
    
    var inputLabelIndex = -1
    
    var newQuestion = Question().newQuestion()
    var guessWords = [String]()
    var questionWords = [String]()
    var emojiResults = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func inputLetter(_ sender: UIButton) {
        inputLabelIndex += 1
        deleteBtn.isEnabled = true
        let labelOrder = inputLabelIndex % 5
        if labelOrder == 4 {
            keyboardEnable(bool: false)
        }
        guessLabels[inputLabelIndex].text = sender.configuration?.title
        
    }
    
    @IBAction func enterWord(_ sender: UIButton) {
        let firstNum = inputLabelIndex - 4
        var guessWord = ""
        //答案單字變array
        for character in newQuestion {
            questionWords.append(String(character))
        }
        print(newQuestion)
        //猜的單字變字串 & array
        for i in firstNum ... inputLabelIndex {
            let character = guessLabels[i].text!
            guessWords.append(character)
            guessWord += character
            if questionWords[i] == guessWords[i] {
                guessLabels[i].backgroundColor = CheckResult.correct.color
                emojiResults.append(CheckResult.correct.emoji)
            } else if newQuestion.contains(character) {
                guessLabels[i].backgroundColor = CheckResult.wrongPlace.color
                emojiResults.append(CheckResult.wrongPlace.emoji)
            } else {
                guessLabels[i].backgroundColor = CheckResult.wrong.color
                emojiResults.append(CheckResult.wrong.emoji)
            }
        }
        keyboardEnable(bool: true)
        print(emojiResults)
        if inputLabelIndex == 39 {
            //結國view
        }
    }
    @IBAction func deleteLast(_ sender: UIButton) {
        guessLabels[inputLabelIndex].text = ""
        inputLabelIndex -= 1
        keyboardEnable(bool: true)
    }
    
    func keyboardEnable(bool:Bool) {
        if bool != true {
            for i in 0..<keyBoardBtns.count {
                keyBoardBtns[i].isEnabled = false
            }
            enterBtn.isEnabled = true
        } else {
            for i in 0..<keyBoardBtns.count {
                keyBoardBtns[i].isEnabled = true
            }
            enterBtn.isEnabled = false
        }
    }
    
    func updateUI() {
        inputLabelIndex = -1
        newQuestion = Question().newQuestion()
        guessWords = [String]()
        questionWords = [String]()
        emojiResults = [String]()
        for i in 0..<guessLabels.count {
            guessLabels[i].text = ""
        }
        keyboardEnable(bool: true)
    }
}

