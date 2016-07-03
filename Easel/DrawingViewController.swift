//
//  ViewController.swift
//  Easel
//
//  Created by Chase McElroy on 7/1/16.
//  Copyright © 2016 Chase McElroy. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    
    var red : CGFloat = 0.0
    var green : CGFloat = 0.0
    var blue : CGFloat = 0.0
    
    var lastPoint = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DrawingViewController.appBecameActive), name: UIApplicationDidBecomeActiveNotification, object: nil)
        
        blueTapped(UIButton())
    }
    
    func appBecameActive() {
        self.buttonsStackView.hidden = false
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            let point = touch.locationInView(self.imageView)
            self.lastPoint = point
        }
        
        
        self.buttonsStackView.hidden = true
    }
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            let point = touch.locationInView(self.imageView)
         
            drawBetweenPoints(self.lastPoint, secondPoint: point)
            
            // remove this to maike it awesome
            self.lastPoint = point
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.locationInView(self.imageView)
            
            drawBetweenPoints(self.lastPoint, secondPoint: point)
        }
        
        self.buttonsStackView.hidden = false
    }
    
    func drawBetweenPoints(firstPoint:CGPoint, secondPoint:CGPoint) {
        UIGraphicsBeginImageContext(self.imageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        self.imageView.image?.drawInRect(CGRect(x: 0, y: 0, width: self.imageView.frame.size.width, height: self.imageView.frame.size.height))
        CGContextMoveToPoint(context, firstPoint.x, firstPoint.y)
        CGContextAddLineToPoint(context, secondPoint.x, secondPoint.y)
        
        // randomTapped(UIButton()) <- add this to make it awesome rainbowy
        CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
        
        
        CGContextSetLineCap(context, .Round)
        CGContextSetLineWidth(context, brushSize)
        
        CGContextStrokePath(context)
        
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        
        UIGraphicsEndImageContext()
    }
    
    func eraseEasel() {
        self.imageView.image = nil
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "drawingToSettingsSegue" {
            let settingsVC = segue.destinationViewController as! SettingsViewController
            settingsVC.drawingVC = self
        }
    }
    
    @IBAction func blueTapped(sender: AnyObject) {
        self.red = 56 / 255
        self.green = 109 / 255
        self.blue = 229 / 255
    }
    
    @IBAction func greenTapped(sender: AnyObject) {
        self.red = 37 / 255
        self.green = 235 / 255
        self.blue = 114 / 255    }
    
    @IBAction func redTapped(sender: AnyObject) {
        self.red = 229 / 255
        self.green = 56 / 255
        self.blue = 56 / 255
    }
    
    @IBAction func yellowTapped(sender: AnyObject) {
        self.red = 249 / 255
        self.green = 215 / 255
        self.blue = 23 / 255
    }
    
    @IBAction func randomTapped(sender: AnyObject) {
        self.red = CGFloat(arc4random_uniform(255)) / 255
        self.green = CGFloat(arc4random_uniform(255)) / 255
        self.blue = CGFloat(arc4random_uniform(255)) / 255
    }
    
    
}

