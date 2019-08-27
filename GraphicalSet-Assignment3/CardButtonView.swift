//
//  CardButtonView.swift
//  GraphicalSet-Assignment3
//
//  Created by Shakaib Akhtar on 26/08/2019.
//  Copyright © 2019 iParagons. All rights reserved.
//

import UIKit

class CardButtonView: UIButton {

    let leftRightMargin: CGFloat = 3
    
    var jumpOfX = 20
    
    let count = 3
    
    override func draw(_ rect: CGRect) {
        self.layer.backgroundColor = UIColor.white.cgColor
        let path = UIBezierPath()
        
        jumpOfX = Int(bounds.maxX / CGFloat(count + 1))
        
        for shapeNum in 1...count {
            let x1: CGFloat = CGFloat(jumpOfX * shapeNum)
            let x2: CGFloat = CGFloat(shapeNum) * leftRightMargin
            let currentStartingX: CGFloat = x1 + x2 - 5
            let currentStartingY: CGFloat = bounds.maxY / 3
            
            path.move(to: CGPoint(x: currentStartingX, y: currentStartingY))
            path.addLine(to: CGPoint(x: currentStartingX + CGFloat(jumpOfX / 2), y: currentStartingY + (currentStartingY / 2)))
            path.addLine(to: CGPoint(x: path.currentPoint.x - CGFloat(jumpOfX / 2), y: path.currentPoint.y + (currentStartingY / 2)))
            path.addLine(to: CGPoint(x: path.currentPoint.x - CGFloat(jumpOfX / 2), y: path.currentPoint.y - (currentStartingY / 2)))
            
            path.close()
        }
        
        path.lineWidth = 2.0
        //UIColor.green.setFill()
        UIColor.red.setStroke()
        path.stroke()
        //path.fill()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))
        
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTap(sender: UITapGestureRecognizer) {
        // let location = sender.location(in: view)
        // User tapped at the point above. Do something with that if you want.
        print("custom button typed")
    }

}
