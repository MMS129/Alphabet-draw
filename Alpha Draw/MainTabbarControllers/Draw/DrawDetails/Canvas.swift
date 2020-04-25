//
//  Canvas.swift
//  Ezllama
//
//  Created by Siam on 3/19/20.
//  Copyright © 2020 REVE Systems. All rights reserved.
//

import UIKit
import Foundation

class Canvas: UIView {
    
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeWidth:Float = 4.0
    fileprivate var lastPoppedLine:Line?
    fileprivate var poppedArray = [Line]()
    
    func setStrokeColor(color:UIColor){
        self.strokeColor = color
    }
    
    func setStrokeWidth(width:Float){
        self.strokeWidth = width * 10.0
    }
    
    func undo(){
        lastPoppedLine = lines.popLast()
        if(lastPoppedLine != nil)
        {
            poppedArray.append(lastPoppedLine!)
            setNeedsDisplay()
        }
        
        
    }
    
    func redo()
    {
        if let redoLine = poppedArray.popLast()
        {
            lines.append(redoLine)
            setNeedsDisplay()
        }
        
    }
    
    func clear(){
        lines.removeAll()
        poppedArray.removeAll()
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else{
            return
        }
        
        
        context.setLineCap(.round)
        
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidth))
            for(index,point) in line.points.enumerated()
            {
                if index == 0{
                    context.move(to: point)
                }
                else{
                    context.addLine(to: point)
                }
            }
            context.strokePath()
        }
    
    }
    
    //var line = [CGPoint]()
    
    var lines = [Line]()
    var strokeColors = [CGColor]()
    
    //track touch begin
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // If a new touch is detected , adding a new line lineList
        lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
        //strokeColors.append(contextStrokeColor!)
        
    }
    
    // track the finger as we move across screen
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else{
            return
        }
        //print(point)
        //print(self.frame.size.height)
        //get the last line to draw points in last line
        guard var lastLine = lines.popLast() else {return }
        lastLine.points.append(point)
        
        // as we've popped the lastLine adding again to lineList
        lines.append(lastLine)
        
        //line.append(point)
        self.setNeedsDisplay()
    }
    
}
