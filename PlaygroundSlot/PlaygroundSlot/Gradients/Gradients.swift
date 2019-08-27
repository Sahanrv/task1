//
//  Gradients.swift
//  PlaygroundSlot
//
//  Created by TreineticMacbook003 on 8/9/19.
//  Copyright © 2019 TreineticMacbook003. All rights reserved.
//


import Foundation
import UIKit

class Gradients:UIView{
    static func  setGradientBackground() -> CAGradientLayer {
        let colorTop =  UIColor(red: 80.0/255.0, green: 18.0/255.0, blue: 18.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 165.0/255.0, green: 50.0/255.0, blue: 11.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        
        return gradientLayer;
        //        gradientLayer.frame = self.view.bounds
        //        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    static func  setGradientBackgroundCard() -> CAGradientLayer {
        let colorTop =  UIColor(red: 80.0/255.0, green: 18.0/255.0, blue: 18.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 16.0/255.0, green: 4.0/255.0, blue: 4.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        
        return gradientLayer;
    }
}

