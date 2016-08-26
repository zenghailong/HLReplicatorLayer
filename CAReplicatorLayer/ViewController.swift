//
//  ViewController.swift
//  CAReplicatorLayer
//
//  Created by 曾海龙 on 16/8/25.
//  Copyright © 2016年 galaxy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    @IBOutlet weak var showView: UIView!
    
    var replicatorLayer = CAReplicatorLayer()
    
    var instanceLayer = CALayer()
    
    var fadeAnination : CABasicAnimation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityView.startAnimating()
        
        replicatorLayer.frame = showView.bounds
        replicatorLayer.instanceColor = UIColor.grayColor().CGColor
        showView.layer.addSublayer(replicatorLayer)
        
        let layerWidth:CGFloat = 10.0
        let midX = CGRectGetMidX(showView.bounds) - layerWidth/2
        instanceLayer.frame = CGRectMake(midX, 0, layerWidth, layerWidth * 2.5)
        instanceLayer.backgroundColor = UIColor.whiteColor().CGColor
        replicatorLayer.addSublayer(instanceLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func slider(sender: UISlider) {
        let count : Int  = Int(sender.value * 30)
        replicatorLayer.instanceCount = count
        if sender.value == 1 {
            
            replicatorLayer.instanceDelay = CFTimeInterval(1.0/Double(count))
            addAnimation()
        } else {
            
            if fadeAnination != nil {
                instanceLayer.opacity = 1.0
                instanceLayer.removeAnimationForKey("fader")
            }
        }
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(Float(M_PI * 2.0) * sender.value / Float(count)), 0.0, 0.0, 1.0)
    }
    
    func addAnimation() {
        fadeAnination = CABasicAnimation(keyPath:"opacity")
        fadeAnination.fromValue = 1.0
        fadeAnination.toValue = 0.0
        fadeAnination.duration = 1.0
        fadeAnination.repeatCount = Float(Int.max)
        instanceLayer.opacity = 0.0
        instanceLayer.addAnimation(fadeAnination, forKey:"fader")
    }

}

