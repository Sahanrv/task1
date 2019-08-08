//
//  Gradients.swift
//  LuckyStrike
//
//  Created by TreineticMacbook003 on 8/5/19.
//  Copyright © 2019 TreineticMacbook003. All rights reserved.
//

import Foundation
import UIKit

class Gradient:UIView{
    static var gradientLayer : CAGradientLayer!
    
    static func  setGradientBackground() -> CAGradientLayer {
        //gradientLayer?.removeFromSuperlayer()
        let colorTop =  UIColor(red: 241.0/255.0, green: 196.0/255.0, blue: 15.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 246.0/255.0, green: 219.0/255.0, blue: 111.0/255.0, alpha: 1.0).cgColor
        
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.name = "setGradient"
        
        print("set gradient")
        return gradientLayer;
        //        gradientLayer.frame = self.view.bounds
        //        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    static func  resetGradientBackground() -> CAGradientLayer {
        //gradientLayer?.removeFromSuperlayer()
        let colorTop =  UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.name = "resetGradient"
        
        print("reset gradient")
      
        return gradientLayer;
    }
}

