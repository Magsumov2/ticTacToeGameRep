//
//  aCrossView.swift
//  PlayingCard
//
//  Created by муса магсумов on 14/03/2019.
//  Copyright © 2019 Муса Магсумов. All rights reserved.
//

import UIKit

@IBDesignable class aCrossView: UIView {
    func creatPath()->UIBezierPath{
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 280, y: 300))
        path.move(to: CGPoint(x: 70, y: 0))
       path.addLine(to: CGPoint(x: 1, y: 71))
       
        path.close()
        return path
    }

    override func draw(_ rect: CGRect) {
        let path = creatPath()
        let fillColor = UIColor.white
        fillColor.setFill()
        path.lineWidth = 25.0
        let strokeColor = UIColor.black
        strokeColor.setStroke()
        
        path.fill()
        path.stroke()
        
    }


}
