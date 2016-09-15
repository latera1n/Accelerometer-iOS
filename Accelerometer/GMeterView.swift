//
//  GMeterView.swift
//  Accelerometer
//
//  Created by DengYuchi on 9/14/16.
//  Copyright © 2016 LateRain. All rights reserved.
//

import UIKit

@IBDesignable class GMeterView: UIView {
    
    var gravityCenterDot: UIBezierPath!
    
    var isInitialDraw = true
    
    var width: Double = 0.0
    var height: Double = 0.0
    
    var gravityCenterX: CGFloat = 0.0
    var gravityCenterY: CGFloat = 0.0

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func draw(_ rect: CGRect) {
        if isInitialDraw {
            width = Double(rect.width)
            height = Double(rect.height)
            gravityCenterDot = UIBezierPath(ovalIn: CGRect(x: rect.width / 2.0 - 5.0, y: rect.height / 2.0 - 5.0, width: 10.0, height: 10.0))
            isInitialDraw = false
        }
        
        /*
        let outerPath = UIBezierPath(ovalIn: CGRect(x: 0.5, y: 0.5, width: rect.width - 1.0, height: rect.height - 1.0))
        let middlePath = UIBezierPath(ovalIn: CGRect(x: rect.width / 6.0, y: rect.height / 6.0, width: (rect.width / 3.0 * 2.0) - 1, height: (rect.width / 3.0 * 2.0) - 1))
        let innerPath = UIBezierPath(ovalIn: CGRect(x: rect.width / 3.0, y: rect.height / 3.0, width: (rect.width / 3.0) - 1, height: (rect.width / 3.0) - 1))
        let centerDot = UIBezierPath(ovalIn: CGRect(x: rect.width / 2.0 - 1.0, y: rect.height / 2.0 - 1.0, width: 2.0, height: 2.0))
        
        outerPath.stroke()
        middlePath.stroke()
        innerPath.stroke()
        centerDot.stroke()
        
        let upperVerticalLine = UIBezierPath()
        upperVerticalLine.move(to: CGPoint(x: rect.width / 2.0, y: 8.0))
        upperVerticalLine.addLine(to: CGPoint(x: rect.width / 2.0, y: rect.height / 2.0 - 8.0))
        let bottomVerticalLine = UIBezierPath()
        bottomVerticalLine.move(to: CGPoint(x: rect.width / 2.0, y: rect.height / 2.0 + 8.0))
        bottomVerticalLine.addLine(to: CGPoint(x: rect.width / 2.0, y: rect.height - 8.0))
        let leftHorizontalLine = UIBezierPath()
        leftHorizontalLine.move(to: CGPoint(x: 8.0, y: rect.height / 2.0))
        leftHorizontalLine.addLine(to: CGPoint(x: rect.width / 2.0 - 8.0, y: rect.height / 2.0))
        let rightHorizontalLine = UIBezierPath()
        rightHorizontalLine.move(to: CGPoint(x: rect.width / 2.0 + 8.0, y: rect.height / 2.0))
        rightHorizontalLine.addLine(to: CGPoint(x: rect.width - 8.0, y: rect.height / 2.0))
        
        upperVerticalLine.stroke()
        bottomVerticalLine.stroke()
        leftHorizontalLine.stroke()
        rightHorizontalLine.stroke()
        */
        
        gravityCenterDot = UIBezierPath(ovalIn: CGRect(x: gravityCenterX, y: gravityCenterY, width: 10.0, height: 10.0))
        UIColor.red.setFill()
        gravityCenterDot.fill()
    }
    
    func updateGravityCenter(x: Double, y: Double) {
        let r = sqrt(x * x + y * y)
        let xCalculated = r > 3.0 ? x * 3.0 / r : x
        let yCalculated = r > 3.0 ? y * 3.0 / r : y
        gravityCenterX = CGFloat(width - (xCalculated * width / 6.0 + width / 2.0) - 5.0)
        gravityCenterY = CGFloat(height - (yCalculated * height / 6.0 + height / 2.0) - 5.0)
        self.setNeedsDisplay()
    }

}
