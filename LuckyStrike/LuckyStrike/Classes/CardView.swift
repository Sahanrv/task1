//
//  CardView.swift
//  LuckyStrike
//
//  Created by TreineticMacbook003 on 8/7/19.
//  Copyright © 2019 TreineticMacbook003. All rights reserved.
//
import Foundation
import UIKit
class CardView: UIView {
    var cornerRadius : CGFloat = 5
    var shadowColor : UIColor? = UIColor.black
    let shadowOffWidth : Int = 0
    let shadowOffHeight : Int = 3
    var shadowOpacity : Float = 0.2
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffWidth, height: shadowOffHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = shadowOpacity
    }
}
