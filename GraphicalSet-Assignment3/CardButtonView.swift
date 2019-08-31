//
//  CardButtonView.swift
//  GraphicalSet-Assignment3
//
//  Created by Shakaib Akhtar on 26/08/2019.
//  Copyright © 2019 iParagons. All rights reserved.
//

import UIKit

class CardButtonView: UIButton {
    
    var leftRightMargin: CGFloat = 3
    
    var count: Int! = 3
    var shape: String!
    var color: UIColor!
    var filling: String!
    
    override func draw(_ rect: CGRect) {
        self.layer.backgroundColor = UIColor.white.cgColor
        
        switch shape {
        case "diamonds":
            drawDiamonds()
        case "ovals":
            drawOvals()
        case "squiggles":
            drawSquiggles()
        default:
            print("select shape first")
        }
    }
    
    func applyFilling(toPath path: UIBezierPath) {
        switch filling {
        case "outline":
            color.setStroke()
            path.stroke()
            break
        case "filled":
            color.setFill()
            path.fill()
            break
        case "striped":
            path.lineWidth = 2.0
            color.setStroke()
            path.stroke()
            path.addClip()
            
            var currentX: CGFloat = 0
            
            let stripedPath = UIBezierPath()
            stripedPath.lineWidth = 1.0
            
            while currentX < frame.size.width {
                stripedPath.move(to: CGPoint(x: currentX, y: 0))
                stripedPath.addLine(to: CGPoint(x: currentX, y: frame.size.height))
                currentX += 0.06 * frame.size.width
            }
            
            color.setStroke()
            stripedPath.stroke()
            
            break
        default:
            print("filling not applied")
        }
    }
    
    func drawSquiggles() {
        let path = UIBezierPath()
        
        leftRightMargin = CGFloat(bounds.maxX / 12)
        
        let jumpOfX = Int(bounds.maxX / CGFloat(count + 2))
        
        for shapeNum in 1...count {
            let x1: CGFloat = CGFloat(jumpOfX * shapeNum - jumpOfX / 2)
            let x2: CGFloat = CGFloat(shapeNum) * leftRightMargin
            
            let currentStartingX: CGFloat = x1 + x2 - 5
            let currentStartingY: CGFloat = bounds.maxY / 2
            
            path.move(to: CGPoint(x: currentStartingX, y: currentStartingY / 2))

            path.addLine(to: CGPoint(x: currentStartingX + CGFloat(jumpOfX), y: currentStartingY / 2))
            
            path.addCurve(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y + currentStartingY), controlPoint1: CGPoint(x: path.currentPoint.x - CGFloat(jumpOfX / 2), y: CGFloat(path.currentPoint.y + currentStartingY / 2)), controlPoint2: CGPoint(x: path.currentPoint.x + CGFloat(jumpOfX / 2), y: CGFloat(path.currentPoint.y + currentStartingY / 2)))
            
            path.addLine(to: CGPoint(x: currentStartingX, y: path.currentPoint.y))
            
            path.addCurve(to: CGPoint(x: currentStartingX, y: currentStartingY / 2), controlPoint1: CGPoint(x: path.currentPoint.x + CGFloat(jumpOfX / 2), y: CGFloat(path.currentPoint.y - currentStartingY / 2)), controlPoint2: CGPoint(x: path.currentPoint.x - CGFloat(jumpOfX / 2), y: CGFloat(path.currentPoint.y - currentStartingY / 2)))
            
            path.close()
        }
        
        path.lineWidth = 2.0
        
        applyFilling(toPath: path)
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))
        
//        self.isUserInteractionEnabled = true
//        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func drawOvals() {
        let path = UIBezierPath()
        
        let jumpOfX = Int(bounds.maxX / CGFloat(count + 1))
        
        for shapeNum in 1...count {
            let x1: CGFloat = CGFloat(jumpOfX * shapeNum - jumpOfX / 2)
            let x2: CGFloat = CGFloat(shapeNum) * leftRightMargin
            
            let currentStartingX: CGFloat = x1 + x2 - 5
            let currentStartingY: CGFloat = bounds.maxY / 2
            
            path.move(to: CGPoint(x: currentStartingX, y: currentStartingY / 2))
            
            path.addCurve(to: CGPoint(x: currentStartingX + CGFloat(jumpOfX), y: currentStartingY / 2), controlPoint1: CGPoint(x: currentStartingX + CGFloat(jumpOfX / 8), y: currentStartingY/4), controlPoint2: CGPoint(x: currentStartingX + CGFloat(jumpOfX), y: currentStartingY/4))
            
            path.addLine(to: CGPoint(x: currentStartingX + CGFloat(jumpOfX), y: path.currentPoint.y + currentStartingY))

            path.addCurve(to: CGPoint(x: path.currentPoint.x - CGFloat(jumpOfX), y: path.currentPoint.y), controlPoint1: CGPoint(x: path.currentPoint.x - CGFloat(jumpOfX / 8), y: path.currentPoint.y + currentStartingY / 3), controlPoint2: CGPoint(x: currentStartingX + CGFloat(jumpOfX / 8),y: path.currentPoint.y + currentStartingY / 3))
            
            path.close()
        }
        
        path.lineWidth = 2.0
        //UIColor.green.setFill()
        color.setStroke()
        path.stroke()
        //path.fill()
        
        applyFilling(toPath: path)
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))
//
//        self.isUserInteractionEnabled = true
//        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func drawDiamonds() {
        let path = UIBezierPath()
        
        let jumpOfX = Int(bounds.maxX / CGFloat(count + 1))
        
        for shapeNum in 1...count {
            let x1: CGFloat = CGFloat(jumpOfX * shapeNum)
            let x2: CGFloat = CGFloat(shapeNum) * leftRightMargin
            let currentStartingX: CGFloat = x1 + x2 - 5
            let currentStartingY: CGFloat = bounds.maxY / 2
            
            path.move(to: CGPoint(x: currentStartingX, y: currentStartingY / 2))
            path.addLine(to: CGPoint(x: currentStartingX + CGFloat(jumpOfX / 2), y: currentStartingY))
            path.addLine(to: CGPoint(x: path.currentPoint.x - CGFloat(jumpOfX / 2), y: path.currentPoint.y + (currentStartingY / 2)))
            path.addLine(to: CGPoint(x: path.currentPoint.x - CGFloat(jumpOfX / 2), y: path.currentPoint.y - (currentStartingY / 2)))
            
            path.close()
        }
        
        path.lineWidth = 2.0
        //UIColor.green.setFill()
        color.setStroke()
        path.stroke()
        //path.fill()
        
        applyFilling(toPath: path)
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))
//        
//        self.isUserInteractionEnabled = true
//        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
//    @objc func didTap(sender: UITapGestureRecognizer) {
//        // let location = sender.location(in: view)
//        // User tapped at the point above. Do something with that if you want.
//
//        if self.layer.borderWidth != 3.0 {
//            self.layer.borderWidth = 3.0
//            self.layer.borderColor = UIColor.white.cgColor
//        }
//        else {
//            self.layer.borderColor = UIColor.black.cgColor
//            self.layer.borderWidth = 1.0
//        }
//    }
    
//    static func addButton(mainView: PlayingCardContainerView, xCoordinate: Int, yCoordinate: Int, btnWidth: Int, btnHeight: Int) {
//        let cardView:CardButtonView = CardButtonView(frame:CGRect(x: xCoordinate, y: yCoordinate, width: btnWidth, height: btnHeight))
//        mainView.addSubview(cardView)
//    }

}
