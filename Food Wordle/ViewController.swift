//
//  ViewController.swift
//  Food Wordle
//
//  Created by Jube on 2022/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var explainView: UIView!
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
        enterBtn.isEnabled = false
        keyboardEnable(bool: false)
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
        //答案單字變questionWords array
        for character in newQuestion {
            questionWords.append(String(character))
        }
        //翻卡動畫
        flipCard(views: guessLabels, num: firstNum)
        keyboardEnable(bool: true)
        //印emoji字串
        DispatchQueue.main.asyncAfter(deadline: .now()+2){
            //let resultMessage = self.resultEmoji(rowNum: self.inputLabelIndex ,emojiArray: self.emojiResults)
            let fiveLabelsCorrect = self.guessLabels[firstNum].backgroundColor == CheckResult.correct.color && self.guessLabels[firstNum+1].backgroundColor == CheckResult.correct.color && self.guessLabels[firstNum+2].backgroundColor == CheckResult.correct.color && self.guessLabels[firstNum+3].backgroundColor == CheckResult.correct.color && self.guessLabels[self.inputLabelIndex].backgroundColor == CheckResult.correct.color
            if fiveLabelsCorrect {
                //結果view
                self.alert(title: "Congrats!", message: "\n" + self.resultEmoji(rowNum: self.inputLabelIndex ,emojiArray: self.emojiResults), actionTitle: "Play Again")
                self.updateUI()
            } else if self.inputLabelIndex == 39 {
                self.alert(title: "Answer is...", message: "\(self.newQuestion)\n" + self.resultEmoji(rowNum: self.inputLabelIndex ,emojiArray: self.emojiResults), actionTitle: "Play Again")
                self.updateUI()
            }
        }
        deleteBtn.isEnabled = false
    }
    @IBAction func deleteLast(_ sender: UIButton) {
        if inputLabelIndex % 5 != 0 {
            keyboardEnable(bool: true)
        } else {
            deleteBtn.isEnabled = false
        }
        guessLabels[inputLabelIndex].text = ""
        inputLabelIndex -= 1
    }
    
    @IBAction func colseExplainView(_ sender: Any) {
        explainView.isHidden = true
        keyboardEnable(bool: true)
    }
    @IBAction func explainViewOpen(_ sender: Any) {
        explainView.isHidden = false
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
            guessLabels[i].backgroundColor = CheckResult.normal.color
        }
        for j in 0..<keyBoardBtns.count {
            keyBoardBtns[j].configuration?.baseBackgroundColor = UIColor(red: 38/255, green: 56/255, blue: 89/255, alpha: 1)
        }
        keyboardEnable(bool: true)
    }
    
    func resultEmoji(rowNum:Int, emojiArray: Array<String>) -> String {
        var emojiString = ""
        let endRow = rowNum / 5 + 1
        for j in 1...endRow {
            for i in 1...5 {
                emojiString += emojiArray[j*5-(6-i)]
            }
            emojiString += "\n"
        }
        return emojiString
    }
    
    func flipCard(views: Array<UILabel>, num: Int) {
        //一張一張接續翻牌
        for i in num ... num+4 {
            //依序延遲翻牌
            let delayTime = DispatchTimeInterval.nanoseconds(i % 5 * 100000000)
            DispatchQueue.main.asyncAfter(deadline: .now()+delayTime){
                // animation
                UIView.transition(with: views[i], duration: 0.6, options: .transitionFlipFromTop, animations: nil, completion: nil)
                //猜的單字變guessWords array
                let character = views[i].text!
                self.guessWords.append(character)
                //字母分別對答案
                if self.questionWords[i] == self.guessWords[i] {
                    //字卡背景顏色變換
                    views[i].backgroundColor = CheckResult.correct.color
                    //儲存emoji
                    self.emojiResults.append(CheckResult.correct.emoji)
                    //鍵盤背景顏色轉換
                    for j in 0..<self.keyBoardBtns.count {
                        let keyboardCharacter = self.keyBoardBtns[j].configuration?.title!
                        if keyboardCharacter == self.questionWords[i] {
                            self.keyBoardBtns[j].configuration?.baseBackgroundColor = CheckResult.correct.color
                        }
                    }
                } else if self.newQuestion.contains(character) {
                    views[i].backgroundColor = CheckResult.wrongPlace.color
                    self.emojiResults.append(CheckResult.wrongPlace.emoji)
                    for j in 0..<self.keyBoardBtns.count {
                        let keyboardCharacter = self.keyBoardBtns[j].configuration?.title!
                        if keyboardCharacter == self.guessWords[i] {
                            self.keyBoardBtns[j].configuration?.baseBackgroundColor = CheckResult.wrongPlace.color
                        }
                    }
                } else {
                    views[i].backgroundColor = CheckResult.wrong.color
                    self.emojiResults.append(CheckResult.wrong.emoji)
                    for j in 0..<self.keyBoardBtns.count {
                        let keyboardCharacter = self.keyBoardBtns[j].configuration?.title!
                        if keyboardCharacter == self.guessWords[i] {
                            self.keyBoardBtns[j].configuration?.baseBackgroundColor = CheckResult.wrong.color
                        }
                    }
                }
            }
        }
    }
    
    func alert(title:String, message:String, actionTitle:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionBtn = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alertController.addAction(actionBtn)
        present(alertController, animated: true, completion: nil)
    }
    
}

