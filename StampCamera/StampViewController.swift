//
//  StampViewController.swift
//  StampCamera
//
//  Created by Tekuru on 2015/07/25.
//  Copyright (c) 2015年 Tekuru. All rights reserved.
//

import UIKit

class StampViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var imageArray: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 1...6{
            imageArray.append(UIImage(named: "\(i).png")!)
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = imageArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        
        let stamp = Stamp()
        stamp.image = imageArray[indexPath.row]
        var aD = UIApplication.sharedApplication().delegate as! AppDelegate
        aD.stampArray.append(stamp)
        aD.isNewStampAdded = true
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func closeTapped(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
