//
//  TicTacToeGAme.swift
//  ticTacToeGame
//
//  Created by муса магсумов on 27/02/2019.
//  Copyright © 2019 Муса Магсумов. All rights reserved.
//

import Foundation

class TicTacToeGame{
    var counter:Int = 1
    var buttons = [Players]()
    
    func resetValues(){
        for index in buttons.indices{
            counter = 1
            buttons[index].firstPlayer = false
            buttons[index].secondPlayer = false
            
        }
    }
    
    func choosenButton(at index:Int){
        if counter % 2 != 0{
            buttons[index].firstPlayer = true
            counter+=1
        }else{
            buttons[index].secondPlayer = true
            counter+=1
        }
    }
    
    init(numOfclickButtons:Int) {
        for _ in 1...numOfclickButtons{
            let clicOnButton = Players()
            buttons+=[clicOnButton]
        }
    }
}
extension TicTacToeGame{
    func checkWinnersForFirstPlayer()->(Bool,Int) {
        
        if buttons[0].firstPlayer == true && buttons[1].firstPlayer == true && buttons[2].firstPlayer == true {return (true,012)}
        else if buttons[3].firstPlayer == true && buttons[4].firstPlayer == true && buttons[5].firstPlayer == true{return (true,345)}
        else if buttons[6].firstPlayer == true && buttons[7].firstPlayer == true && buttons[8].firstPlayer == true{return (true,678)}
        else if buttons[0].firstPlayer == true && buttons[3].firstPlayer == true && buttons[6].firstPlayer == true{return (true,036)}
        else if buttons[1].firstPlayer == true && buttons[4].firstPlayer == true && buttons[7].firstPlayer == true{return (true,147)}
        else if buttons[2].firstPlayer == true && buttons[5].firstPlayer == true && buttons[8].firstPlayer == true{return (true,258)}
        else if buttons[0].firstPlayer == true && buttons[4].firstPlayer == true && buttons[8].firstPlayer == true{return (true,048)}
        else if buttons[2].firstPlayer == true && buttons[4].firstPlayer == true && buttons[6].firstPlayer == true{return (true,246)}
            else{return (false,000)}
        }
    func checkWinnersForSecondPlayer()->(Bool,Int) {
        if buttons[0].secondPlayer == true && buttons[1].secondPlayer == true && buttons[2].secondPlayer == true {return (true,012)}
        else if buttons[3].secondPlayer == true && buttons[4].secondPlayer == true && buttons[5].secondPlayer == true{return (true,345)}
        else if buttons[6].secondPlayer == true && buttons[7].secondPlayer == true && buttons[8].secondPlayer == true{return (true,678)}
        else if buttons[0].secondPlayer == true && buttons[3].secondPlayer == true && buttons[6].secondPlayer == true{return (true,036)}
        else if buttons[1].secondPlayer == true && buttons[4].secondPlayer == true && buttons[7].secondPlayer == true{return (true,147)}
        else if buttons[2].secondPlayer == true && buttons[5].secondPlayer == true && buttons[8].secondPlayer == true{return (true,258)}
        else if buttons[0].secondPlayer == true && buttons[4].secondPlayer == true && buttons[8].secondPlayer == true{return (true,048)}
        else if buttons[2].secondPlayer == true && buttons[4].secondPlayer == true && buttons[6].secondPlayer == true{return (true,246)}
        else{return (false,000)}
    }
   
}


   
