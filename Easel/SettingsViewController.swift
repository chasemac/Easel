//
//  SettingsViewController.swift
//  Easel
//
//  Created by Chase McElroy on 7/1/16.
//  Copyright © 2016 Chase McElroy. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    weak var drawingVC : DrawingViewController? = nil
    @IBOutlet weak var sliderBrushSize: UISlider!
    var newValue: Float = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        sliderBrushSize.value = brushSliderValue
    }
    
    override func viewWillDisappear(animated: Bool) {
        brushSliderValue = newValue
       
    }
    
    @IBAction func eraseTapped(sender: AnyObject) {
        self.drawingVC?.eraseEasel()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func shareTapped(sender: AnyObject) {
        if let image = self.drawingVC?.imageView.image {
            let activityVC =  UIActivityViewController(activityItems: [image], applicationActivities: nil)
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func valueChanged(sender: AnyObject) {
        newValue = sliderBrushSize.value
        //print(newValue)
    }
}
