//
//  SlotItem.swift
//  LuckyStrike
//
//  Created by TreineticMacbook003 on 8/6/19.
//  Copyright © 2019 TreineticMacbook003. All rights reserved.
//

import Foundation
import UIKit

class SlotItem : UIView {
    
    var gradiants = [CAGradientLayer]()
    
    var text : String! {
        didSet {
            self.label.text = self.text
        }
    }
    var borderColor : CGColor! {
        didSet {
            outterView.layer.borderColor = self.borderColor
            outterView.layer.borderWidth = self.borderWidth
        }
    }
    var isGradiantShow : Bool = false {
        didSet {
            gradiantView.alpha = self.isGradiantShow ? 1 : 0
        }
    }
    var borderWidth = CGFloat(3) {
        didSet {
            outterView.layer.borderWidth = self.borderWidth
        }
    }
    
    func setGradient(slot : UIView){
        DispatchQueue.main.async {
            let gradientLayer = Gradient.setGradientBackground()
            gradientLayer.frame = slot.bounds
            slot.layer.addSublayer(gradientLayer)
            self.gradiants.append(gradientLayer)
        }
    }
    
    
    @IBOutlet weak var gradiantView: UIView!
    @IBOutlet weak var outterView: UIView!
    @IBOutlet weak var label: UILabel!
    
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initXib()
    
        layoutSubviews()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initXib()
        
        
    }
    
    private func initXib() {
        let nib = UINib.init(nibName: "SlotItem", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    override func layoutSubviews() {
        DispatchQueue.main.async {
            let gradient = CAGradientLayer()
            gradient.frame = self.gradiantView.bounds
            gradient.colors = [Colors.secondary, Colors.accent]
            self.gradiantView.layer.insertSublayer(gradient, at: 0)
        }
    }
    
}
