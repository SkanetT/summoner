//
//  test1.swift
//  LoLProject
//
//  Created by Антон on 17.06.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit


extension UIView {
    func flash(){
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.6
        flash.fromValue = 1
        flash.toValue = 0.2
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = .infinity
        
        layer.add(flash, forKey: nil)
    }
    
    func pulse(){
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: nil)
    }
}
