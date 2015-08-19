//
//  DrawView.swift
//  StampCamera
//
//  Created by Tekuru on 2015/08/08.
//  Copyright (c) 2015年 Tekuru. All rights reserved.
//

import UIKit

class DrawView: UIView {

    var points: [CGPoint] = []
    var color: UIColor = UIColor.redColor()
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        if points.count < 2{
            return
        }
        
        // Drawing code
        var context: CGContextRef = UIGraphicsGetCurrentContext()
        
        CGContextSetStrokeColorWithColor(context, color.CGColor!)
        CGContextSetLineWidth(context, 10.0)
        CGContextSetLineCap(context, kCGLineCapRound)
        
        CGContextMoveToPoint(context, points[0].x, points[0].y)
        for var i=1; i<points.count; ++i{
            var point = points[i]
            CGContextAddLineToPoint(context, point.x, point.y)
            CGContextMoveToPoint(context, point.x, point.y)
        }
        
        CGContextStrokePath(context)
    }
    

}
