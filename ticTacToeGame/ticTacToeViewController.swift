//
//  ViewController.swift
//  ticTacToeGame
//
//  Created by муса магсумов on 26/02/2019.
//  Copyright © 2019 Муса Магсумов. All rights reserved.
//

import UIKit

class ticTacToeViewController: UIViewController {
    private lazy var game = TicTacToeGame(numOfclickButtons:ticTacToeGameCalssicStarter)
    var ticTacToeGameCalssicStarter:Int{
        return clickOnButtons.count
    }
    @IBOutlet weak var firstPlayerLabel: UILabel!
    @IBOutlet weak var secondPlayerLabel: UILabel!
    @IBOutlet var clickOnButtons: [UIButton]!
    @IBOutlet var resetGameButton: UIButton!
    @IBOutlet weak var drawVictoryLabel: UILabel!
    func getLargeNavBar(){
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        } else {
            // Fallback on earlier versions
        }
    }
    @IBAction func gameResetAction(_ sender: UIButton) {
        game.resetValues()
        resetGameLabel(firstPlayerLabel,secondPlayerLabel, thirdLabel: drawVictoryLabel)
        resetGameLabel(secondPlayerLabel,secondPlayerLabel, thirdLabel: drawVictoryLabel)
        for index in clickOnButtons.indices{
            let button = clickOnButtons[index]
            if button.currentTitle == "✖" || button.currentTitle == "O"{
                UIView.transition(with: button, duration: 0.5, options: [.transitionFlipFromRight] , animations: {
                    button.backgroundColor = .white
                    
                    button.isEnabled = true
                    button.setTitle("", for: .normal)
                })
            }else{
                button.isEnabled = true
            }
            
        }
        if #available(iOS 10.0, *) {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5,
                                                           delay: 0,
                                                           options: [],
                                                           animations: {[weak label = firstPlayerLabel] in
                                                            label?.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
                },completion:{ posiotion in
                    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5,
                                                                   delay: 0,
                                                                   options: [],
                                                                   animations: {
                                                                    [weak label = self.firstPlayerLabel] in
                                                                    label?.transform = .identity
                                                                    self.resetGameButton.backgroundColor = .white
                    })
            })
        } else {
            // Fallback on earlier versions
        }
        resetGameButton.isEnabled = false
        if #available(iOS 10.0, *) {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3,
                                                           delay: 0,
                                                           options: [],
                                                           animations: {[weak button = self.resetGameButton] in
                                                            button?.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
                },completion:{ posiotion in
                    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3,
                                                                   delay: 0,
                                                                   options: [],
                                                                   animations: {[weak button = self.resetGameButton] in
                                                                    button?.transform = .identity
                    })
            })
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func updateViewFromModel(_ sender: UIButton!) {
        resetGameButton.isEnabled = true
        if let clickedButton = clickOnButtons.index(of:sender){
            game.choosenButton(at:clickedButton)
            for index in clickOnButtons.indices{
                let button = clickOnButtons[index]
                let clickOnButton = game.buttons[index]
                if clickOnButton.firstPlayer == true && index == clickedButton {
                    UIView.transition(with: button, duration: 0.5, options: [.transitionFlipFromLeft] , animations: {
                        button.setSymbolForButton(symbol: "✖")
                    })
                }
                if clickOnButton.secondPlayer == true && index == clickedButton{
                    UIView.transition(with: button, duration: 0.5, options: [.transitionFlipFromLeft] , animations: {
                        button.setSymbolForButton(symbol: "O")
                    })
                }
            }
            if game.counter % 2 != 0{
                drawMaker()
                updateFirstAndDisableSecond(update: firstPlayerLabel, disable: secondPlayerLabel)
                getResult(in: clickOnButtons, result:game.checkWinnersForSecondPlayer(), winnerLabel: secondPlayerLabel,looserLabel: firstPlayerLabel)
                
            }else{
                drawMaker()
                updateFirstAndDisableSecond(update: secondPlayerLabel, disable: firstPlayerLabel)
                getResult(in: clickOnButtons, result:game.checkWinnersForFirstPlayer(), winnerLabel: firstPlayerLabel,looserLabel: secondPlayerLabel)
            }
        }
    }
    func drawMaker (){
        if game.checkWinnersForFirstPlayer() == (false,000) && game.checkWinnersForSecondPlayer() == (false,000) && game.counter == 10{
            drawVictoryLabel.isHidden = false
            drawVictoryLabel.backgroundColor = .white
            drawVictoryLabel.textColor = .black
            drawVictoryLabel.layer.masksToBounds = true
            drawVictoryLabel.layer.cornerRadius = 10
            drawVictoryLabel.layer.borderWidth = 4
            drawVictoryLabel.layer.borderColor = UIColor.init(red: 0.2, green: 0.8, blue: 0.5, alpha: 0.8).cgColor
            if #available(iOS 10.0, *) {
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5,
                                                               delay: 0,
                                                               options: [],
                                                               animations: {[weak self] in
                                                                self?.drawVictoryLabel.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.5)
                    },completion:{ posiotion in
                        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5,
                                                                       delay: 0,
                                                                       options: [],
                                                                       animations: {
                                                                        self.drawVictoryLabel.transform = .identity
                        })
                })
            } else {
                // Fallback on earlier versions
            }
            resetGameButton.backgroundColor = #colorLiteral(red: 1, green: 0.9387256565, blue: 0.4706455035, alpha: 1)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(swipe())
        startView()
        getLargeNavBar()
    }
    @objc func dismisView(recognizer:UISwipeGestureRecognizer){
        switch recognizer.state{
        case .ended:
            presentingViewController?.dismiss(animated: true)
        default:
          break
        }
        
    }
    
    func swipe()->UISwipeGestureRecognizer{
        let swipe  = UISwipeGestureRecognizer(target: self, action:  #selector(dismisView))
        swipe.direction = .down
        
        
        return swipe
    }
}
extension UIButton{
    func setSymbolForButton( symbol:String){
        self.setTitleColor(.black, for: .normal)
        self.setTitle(symbol, for: .normal)
        self.isEnabled = false
    }
}


extension ticTacToeViewController{
    func resetGameLabel(_ label:UILabel,_ secondLabel:UILabel,thirdLabel:UILabel){
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 8
        label.backgroundColor = .white
        label.layer.borderColor = UIColor.init(red: 1.0, green: 0.3, blue: 0.1, alpha: 0.8).cgColor
        
        secondLabel.layer.borderColor = UIColor.black.cgColor
        secondLabel.layer.cornerRadius = 10
        secondLabel.layer.borderWidth = 4
        secondLabel.backgroundColor = .clear
        
        thirdLabel.layer.borderColor = UIColor.clear.cgColor
        thirdLabel.backgroundColor = .clear
        thirdLabel.textColor = .clear
        
        
    }
    func updateFirstAndDisableSecond(update:UILabel,disable:UILabel){
        update.backgroundColor = .white
        update.layer.masksToBounds = true
        update.layer.cornerRadius = 10
        update.layer.borderWidth = 8
        update.layer.borderColor = UIColor.init(red: 1.0, green: 0.3, blue: 0.1, alpha: 0.8).cgColor
        
        disable.backgroundColor = .clear
        disable.layer.cornerRadius = 10
        disable.layer.borderWidth = 4
        disable.layer.borderColor = UIColor.black.cgColor
    }
    
    func startView(){
        drawVictoryLabel.isHidden = true
        resetGameButton.isEnabled = false
        resetGameButton.layer.cornerRadius = 10
        resetGameButton.layer.borderWidth = 5
        firstPlayerLabel.text = "✖"
        firstPlayerLabel.layer.masksToBounds = true
        firstPlayerLabel.layer.cornerRadius = 10
        firstPlayerLabel.layer.borderWidth = 8
        firstPlayerLabel.layer.borderColor = UIColor.init(red: 1.0, green: 0.3, blue: 0.1, alpha: 0.8).cgColor
        firstPlayerLabel.backgroundColor = .white
        if #available(iOS 10.0, *) {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5,
                                                           delay: 0,
                                                           options: [],
                                                           animations: {[weak label = firstPlayerLabel] in
                                                            label?.transform = CGAffineTransform.identity.scaledBy(x: 1.3, y: 1.3)
                },completion:{ posiotion in
                    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5,
                                                                   delay: 0,
                                                                   options: [],
                                                                   animations: {
                                                                    [weak label = self.firstPlayerLabel] in
                                                                    label?.transform = .identity
                    })
            })
        } else {
            // Fallback on earlier versions
        }
        secondPlayerLabel.layer.cornerRadius = 10
        secondPlayerLabel.layer.borderWidth = 4
        secondPlayerLabel.text = "O"
        for item in clickOnButtons.indices{
            let button = clickOnButtons[item]
            button.isMultipleTouchEnabled = false
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 5
            button.layer.borderColor = UIColor.black.cgColor
        }
    }
    func updateColorforWinnerFirstPlayer(winnerLabel: UILabel,looserLabel: UILabel){
        winnerLabel.layer.cornerRadius = 10
        winnerLabel.layer.borderWidth = 8
        winnerLabel.backgroundColor = .white
        winnerLabel.layer.borderColor = UIColor.init(red: 0.2, green: 0.8, blue: 0.5, alpha: 0.8).cgColor
        if #available(iOS 10.0, *) {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5,
                                                           delay: 0,
                                                           options: [],
                                                           animations: {[weak label =  winnerLabel] in
                                                            label?.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
                },completion:{ posiotion in
                    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5,
                                                                   delay: 0,
                                                                   options: [],
                                                                   animations: {
                                                                    [weak label =  winnerLabel] in
                                                                    label?.transform = .identity
                    })
            })
        } else {
            // Fallback on earlier versions
        }
        looserLabel.backgroundColor = .clear
        looserLabel.layer.cornerRadius = 10
        looserLabel.layer.borderWidth = 4
        looserLabel.layer.borderColor = UIColor.init(red: 1.0, green: 0.3, blue: 0.1, alpha: 0.8).cgColor
        if #available(iOS 10.0, *) {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5,
                                                           delay: 0,
                                                           options: [],
                                                           animations: {[weak label =  looserLabel] in
                                                            label?.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                },completion:{ posiotion in
                    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5,
                                                                   delay: 0,
                                                                   options: [],
                                                                   animations: {
                                                                    [weak label =  looserLabel] in
                                                                    label?.transform = .identity
                    })
            })
        } else {
            // Fallback on earlier versions
        }
        resetGameButton.backgroundColor = #colorLiteral(red: 1, green: 0.9387256565, blue: 0.4706455035, alpha: 1)
    }
    
    func getResult(in arrayOfButtons:[UIButton]!,result:(Bool,Int),winnerLabel: UILabel,looserLabel: UILabel){
        if result == (true, 012){
            for index in arrayOfButtons.indices{
                let button = arrayOfButtons[index]
                if index == 0 || index == 1 || index == 2{
                    UIView.transition(with: button, duration: 0.5, options: [.transitionFlipFromLeft] , animations: {
                        button.backgroundColor = UIColor.init(red: 1.0, green: 0.3, blue: 0.4, alpha: 0.5)
                    })
                }else{
                    button.isEnabled = false
                }
                
            }
            updateColorforWinnerFirstPlayer(winnerLabel: winnerLabel, looserLabel: looserLabel)
        }else if result == (true,345){
            for index in arrayOfButtons.indices{
                let button = arrayOfButtons[index]
                if index == 3 || index == 4 || index == 5{
                    UIView.transition(with: button, duration: 0.5, options: [.transitionFlipFromLeft] , animations: {
                        button.backgroundColor = UIColor.init(red: 1.0, green: 0.3, blue: 0.4, alpha: 0.5)
                    })
                }else{
                    button.isEnabled = false
                }
            }
            updateColorforWinnerFirstPlayer(winnerLabel: winnerLabel, looserLabel: looserLabel)
        }
            
        else if result == (true,678){
            for index in arrayOfButtons.indices{
                let button = arrayOfButtons[index]
                if index == 6 || index == 7 || index == 8{
                    UIView.transition(with: button, duration: 0.5, options: [.transitionFlipFromLeft] , animations: {
                        button.backgroundColor = UIColor.init(red: 1.0, green: 0.3, blue: 0.4, alpha: 0.5)
                    })
                }else{
                    button.isEnabled = false
                }
            }
            updateColorforWinnerFirstPlayer(winnerLabel: winnerLabel, looserLabel: looserLabel)
        }else if result == (true,036){
            for index in arrayOfButtons.indices{
                let button = arrayOfButtons[index]
                if index == 0 || index == 3 || index == 6{
                    UIView.transition(with: button, duration: 0.5, options: [.transitionFlipFromLeft] , animations: {
                        button.backgroundColor = UIColor.init(red: 1.0, green: 0.3, blue: 0.4, alpha: 0.5)
                    })
                }else{
                    button.isEnabled = false
                }
                
            }
            updateColorforWinnerFirstPlayer(winnerLabel: winnerLabel, looserLabel: looserLabel)
        }else if result == (true,147){
            for index in arrayOfButtons.indices{
                let button = arrayOfButtons[index]
                if index == 1 || index == 4 || index == 7{
                    UIView.transition(with: button, duration: 0.5, options: [.transitionFlipFromLeft] , animations: {
                        button.backgroundColor = UIColor.init(red: 1.0, green: 0.3, blue: 0.4, alpha: 0.5)
                    })
                }else{
                    button.isEnabled = false
                }
            }
            updateColorforWinnerFirstPlayer(winnerLabel: winnerLabel, looserLabel: looserLabel)
        }else if result == (true,258){
            for index in arrayOfButtons.indices{
                let button = arrayOfButtons[index]
                if index == 2 || index == 5 || index == 8{
                    UIView.transition(with: button, duration: 0.5, options: [.transitionFlipFromLeft] , animations: {
                        button.backgroundColor = UIColor.init(red: 1.0, green: 0.3, blue: 0.4, alpha: 0.5)
                    })
                }else{
                    button.isEnabled = false
                }
            }
            updateColorforWinnerFirstPlayer(winnerLabel: winnerLabel, looserLabel: looserLabel)
        }else if result == (true,048){
            for index in arrayOfButtons.indices{
                let button = arrayOfButtons[index]
                if index == 0 || index == 4 || index == 8{
                    UIView.transition(with: button, duration: 0.5, options: [.transitionFlipFromLeft] , animations: {
                        button.backgroundColor = UIColor.init(red: 1.0, green: 0.3, blue: 0.4, alpha: 0.5)
                    })
                }else{
                    button.isEnabled = false
                }
            }
            updateColorforWinnerFirstPlayer(winnerLabel: winnerLabel, looserLabel: looserLabel)
        }else if result == (true,246){
            for index in arrayOfButtons.indices{
                let button = arrayOfButtons[index]
                if index == 2 || index == 4 || index == 6{
                    UIView.transition(with: button, duration: 0.5, options: [.transitionFlipFromLeft] , animations: {
                        button.backgroundColor = UIColor.init(red: 1.0, green: 0.3, blue: 0.4, alpha: 0.5)
                    })
                }else{
                    button.isEnabled = false
                }
            }
            updateColorforWinnerFirstPlayer(winnerLabel: winnerLabel, looserLabel: looserLabel)
        }
        
    }
}

