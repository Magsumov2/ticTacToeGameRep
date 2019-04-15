//
//  Cross View.swift
//  ticTacToeGame
//
//  Created by муса магсумов on 14/03/2019.
//  Copyright © 2019 Муса Магсумов. All rights reserved.
//

import UIKit
@IBDesignable class CrossView: UIView {
    
    func creatPath()->UIBezierPath{
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 6, y: 60))
        path.addLine(to: CGPoint(x: 60, y: 6 ))
        
        path.move(to: CGPoint(x: 6, y: 6))
        path.addLine(to: CGPoint(x: 60, y: 60))
        
        path.close()
        return path
    }
    
    override func draw(_ rect: CGRect) {
        let path = creatPath()
        let fillColor = UIColor.white
        fillColor.setFill()
        path.lineWidth = 22.0
        let strokeColor = UIColor.init(red: 0.2, green: 0.8, blue: 0.5, alpha: 0.8)
        strokeColor.setStroke()
        
        path.fill()
        path.stroke()
        
    }
  
}
