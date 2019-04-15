//
//  circleView.swift
//  ticTacToeGame
//
//  Created by муса магсумов on 15/03/2019.
//  Copyright © 2019 Муса Магсумов. All rights reserved.
//

import UIKit

@IBDesignable class CircleView: UIView {
    

        override func draw(_ rect: CGRect) {
            let circle = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: 23.0, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
            circle.lineWidth = 14
            UIColor.clear.setFill()
            UIColor.init(red: 1.0, green: 0.3, blue: 0.1, alpha: 0.8).setStroke()
            circle.fill()
            circle.stroke()
            circle.addClip()
        }
        
        
        
    }



