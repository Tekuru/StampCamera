//
//  Stamp.swift
//  StampCamera
//
//  Created by Tekuru on 2015/08/01.
//  Copyright (c) 2015年 Tekuru. All rights reserved.
//

import UIKit

class Stamp: UIImageView, UIGestureRecognizerDelegate {
    
    var currentTransform:CGAffineTransform!
    var scale: CGFloat = 1.0
    var angle: CGFloat = 0
    var isMoving: Bool = false
    
    override func didMoveToSuperview() {
        var rotationRecognizer: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: "rotationGesture:")
        rotationRecognizer.delegate = self
        self.addGestureRecognizer(rotationRecognizer)
        
        var pinchRecognizer: UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: "pinchGesture:")
        pinchRecognizer.delegate = self
        self.addGestureRecognizer(pinchRecognizer)
        
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.superview?.bringSubviewToFront(self)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        let touch = touches.first as! UITouch
        
        let dx = touch.locationInView(self.superview).x - touch.previousLocationInView(self.superview).x
        let dy = touch.locationInView(self.superview).y - touch.previousLocationInView(self.superview).y
        
        self.center = CGPointMake(self.center.x+dx, self.center.y+dy)
    }
    
    func rotationGesture(gesture: UIRotationGestureRecognizer){
        println("Rotation detected!")
        
        if !isMoving && gesture.state == UIGestureRecognizerState.Began {
            isMoving = true
            currentTransform = self.transform
        }
        else if isMoving && gesture.state == UIGestureRecognizerState.Ended {
            isMoving = false
            scale = 1.0
            angle = 0.0
        }
        
        angle = gesture.rotation
        
        var transform = CGAffineTransformConcat(CGAffineTransformConcat(currentTransform,CGAffineTransformMakeRotation(angle)), CGAffineTransformMakeScale(scale, scale))
        
        self.transform = transform
        
    }
    
    func pinchGesture(gesture: UIPinchGestureRecognizer){
        println("Pinch detected!")
        
        if !isMoving && gesture.state == UIGestureRecognizerState.Began {
            isMoving = true
            currentTransform = self.transform
        }
        else if isMoving && gesture.state == UIGestureRecognizerState.Ended {
            isMoving = false
            scale = 1.0
            angle = 0.0
        }
        
        scale = gesture.scale
        
        var transform = CGAffineTransformConcat(CGAffineTransformConcat(currentTransform, CGAffineTransformMakeRotation(angle)), CGAffineTransformMakeScale(scale, scale))
        
        self.transform = transform;
    }
    
    

}
