//
//  ViewController.swift
//  StampCamera
//
//  Created by Tekuru on 2015/07/25.
//  Copyright (c) 2015年 Tekuru. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var canvasView: UIView!
    @IBOutlet var imageView: UIImageView!
    
    var drawView: DrawView = DrawView()
    var colorNum: Int = 0
    let colorArray:[UIColor] = [UIColor.redColor(), UIColor.blueColor(), UIColor.yellowColor()]
    
    var aD = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if aD.isNewStampAdded {
            let stamp = aD.stampArray.last!
            stamp.frame = CGRectMake(0, 0, 100, 100)
            stamp.center = canvasView.center
            stamp.userInteractionEnabled = true
            canvasView.addSubview(stamp)
            
            aD.isNewStampAdded = false
        }
    }
    
    @IBAction func cameraTapped(){
        let sheet = UIActionSheet()
        sheet.delegate = self
        sheet.addButtonWithTitle("Cancel")
        sheet.addButtonWithTitle("Camera")
        sheet.addButtonWithTitle("Library")
        sheet.cancelButtonIndex = 0
        sheet.showInView(self.view)
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
        if buttonIndex == 0{
            return
        }
        
        var pickerController = UIImagePickerController()
        pickerController.delegate = self
        if buttonIndex == 1{
            pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        }else{
            pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imageView.image = info["UIImagePickerControllerOriginalImage"] as? UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func colorButtonTapped(sender: UIButton){
        colorNum++
        if colorNum >= colorArray.count {
            colorNum = 0
        }
        
        sender.setTitleColor(colorArray[colorNum], forState: UIControlState.Normal)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        drawView = DrawView()
        drawView.frame = canvasView.frame
        drawView.backgroundColor = UIColor.clearColor()
        drawView.color = colorArray[colorNum]
        canvasView.addSubview(drawView)
        
        let touch = touches.first as! UITouch
        let point = touch.locationInView(self.view)
        drawView.points.append(point)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let point = touch.locationInView(self.view)
        drawView.points.append(point)
        
        drawView.setNeedsDisplay()
    }
    
    @IBAction func deleteTapped(){
        if canvasView.subviews.count > 1 {
            let lastSubView = canvasView.subviews.last! as! UIView
            lastSubView.removeFromSuperview()
            if lastSubView.isKindOfClass(Stamp){
                let stamp = lastSubView as! Stamp
                if let index = find(aD.stampArray, stamp){
                    aD.stampArray.removeAtIndex(index)
                }
            }
            
        }
    }
    
    @IBAction func saveTapped(){
        UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, canvasView.opaque, 0.0)
        canvasView.layer.renderInContext(UIGraphicsGetCurrentContext())
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) {
        let alert = UIAlertView()
        alert.title = "保存"
        alert.message = "保存完了です。"
        alert.addButtonWithTitle("OK")
        alert.show()
    }
}

