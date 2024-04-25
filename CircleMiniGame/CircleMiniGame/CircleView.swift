//
//  CircleView.swift
//  CircleMiniGame
//
//  Created by Mikhail Gorbunov on 23.04.2024.
//

import UIKit
import Foundation

    @IBDesignable class CircleView: UIView {
        
        
        var workingView: UIView!
        var xibName: String = "CircleView"
        
        
        override init(frame: CGRect) {
            super.init (frame: frame)
            setCircleView()
        }
        
        required init?(coder: NSCoder) {
            super.init (coder: coder)
            setCircleView()
        }
        
        func getFromXib() -> UIView {
            let bundle = Bundle(for: type(of: self))
            let xib = UINib(nibName: xibName, bundle: bundle)
            let view = xib.instantiate(withOwner: self, options: nil).first as! UIView
            return view
        }
        func setCircleView() {
            workingView = getFromXib()
            workingView.frame = bounds
            workingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            workingView.layer.cornerRadius = frame.size.width / 2
            addSubview(workingView)
        }
            
    }
