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
                            
                           
                            circleViews[view].workingView.frame = CGRect(x: circleViews[view].workingView.frame.origin.x, y: circleViews[view].workingView.frame.origin.y, width: circleViews[view].workingView.frame.width + 20, height: circleViews[view].workingView.frame.height + 20)
                            circleViews[view].workingView.layer.cornerRadius = circleViews[view].workingView.frame.width/2
                            circleViews[view].workingView.backgroundColor = .blue
                            gestureView.isHidden = true
                        }
                    }
                }
            }


        }
    }
    
    
