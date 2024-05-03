//
//  ViewController.swift
//  CircleMiniGame
//
//  Created by Mikhail Gorbunov on 23.04.2024.
//

import UIKit
import Foundation





class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    
    @IBOutlet var circleViews: [CircleView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func panAction(_ gesture: UIPanGestureRecognizer) {
        let gestureTranslation = gesture.translation(in: view)
        guard let gestureView = gesture.view else {return}
        
        gestureView.center = CGPoint (x: gestureView.center.x + gestureTranslation.x,
                                      y: gestureView.center.y + gestureTranslation.y)
        
        gesture.setTranslation(.zero, in: view)
        
        guard gesture.state == .ended    else {return}
        
        for view in 0...circleViews.count-1 {
            
            for x in Int(circleViews[view].frame.minX)...Int(circleViews[view].frame.maxX) {
                    for y in Int(circleViews[view].frame.minY)...Int(circleViews[view].frame.maxY){
                        if Int(gestureView.frame.origin.x) == x && Int(gestureView.frame.origin.y) == y {
                            
                           
                            UIView.animate(withDuration: 3, delay: 0, options: [], animations: {self.circleViews[view].workingView.frame = CGRect(
                                x: self.circleViews[view].workingView.frame.origin.x,
                                y: self.circleViews[view].workingView.frame.origin.y,
                                width: self.circleViews[view].workingView.frame.width + 20,
                                height: self.circleViews[view].workingView.frame.height + 20)
                                self.circleViews[view].workingView.layer.cornerRadius = self.circleViews[view].workingView.frame.width/2})
                            UIView.animate(withDuration: 2, delay: 0, options: [], animations: {self.circleViews[view].workingView.backgroundColor = .systemRed})
                            gestureView.isHidden = true
                        }
                    }
                }
            }
        
        }
    
    }
    
    
