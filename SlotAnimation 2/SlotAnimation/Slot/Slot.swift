//
//  Slot.swift
//  SlotAnimation
//
//  Created by Treinetic Mackbook 005 on 7/30/19.
//  Copyright © 2019 Treinetic Mackbook 005. All rights reserved.
//

import Foundation
import UIKit
class Slot : UIView {
    
    @IBOutlet weak var container: UIView!
    
    var dataSource = ["1", "2", "3", "4", "5", "6", "7"]
    var imageViews = [UIImageView]()
    var numOfView = 5
    var padding = CGFloat(0)
    var speed : Double = 0.4
    var finalValue : String?
    var callback : (() -> Void)?
    var isReversed = false {
        didSet {
            self.container.transform = CGAffineTransform(rotationAngle: .pi)
            self.imageViews.forEach({$0.transform = CGAffineTransform(rotationAngle: .pi)})
        }
    }
    var shoudStop = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initXib()
    }
    
    private func initXib() {
        let xib = UINib.init(nibName: "Slot", bundle: nil)
        let view = xib.instantiate(withOwner: self, options: nil).first as! UIView
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = self.bounds
        addSubview(view)
    }
    
}

extension Slot {
    
    func stop() {
        shoudStop = true
    }
    
    func initializeView() {
        let offset = Int(floor(Double(numOfView) / 2.0))
        
        for position in (offset * -1)...offset {
           
            let x = CGFloat(0)
            let width = container.bounds.width
            let height = container.bounds.height - (padding * 2)
            let y = (height * CGFloat(position)) - padding
            
            let imageView = UIImageView.init(frame: CGRect.init(x: x, y: y, width: width, height: height))
            print(imageView.frame)
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage.init(named: self.dataSource.shuffled()[0])
            if isReversed {
                imageView.transform = CGAffineTransform(rotationAngle: .pi)
            }
            container.addSubview(imageView)
            self.imageViews.append(imageView)
        }
        
        
    }
    
    
    func animate(finalValue : String, times : Int, speed : Double, callback : (() -> Void)?) {
        self.finalValue = finalValue
        self.speed = speed
        self.callback = callback
        shoudStop = false
        animatation(loop : times)
    }
    
    
    private func animatation(loop : Int) {
        if loop <= 0 || shoudStop {
            finalValue = self.imageViews[Int(floor(Double(numOfView) / 2.0)) - 1].description
            self.callback?()
            return
        }
        let height = container.bounds.height - (padding * 2)
        let offset = Int(floor(Double(numOfView) / 2.0))
        initAnimation()
        
        if loop == (offset + 1) {
            self.imageViews[0].image = UIImage.init(named: finalValue ?? "")
        }
        
        UIView.animate(withDuration: self.speed, animations: {
            for x in 1..<self.imageViews.count {
                self.imageViews[x].frame.origin.y += height
            }
        }) { (result) in

        }
        
        Timer.scheduledTimer(withTimeInterval: speed / 2, repeats: false) { (t) in
            let next = loop - 1
            self.animatation(loop: next)
        }
        
    }
    
    
    private func initAnimation() {
        let offset = Int(floor(Double(numOfView) / 2.0))
        let height = container.bounds.height - (padding * 2)
        
        let lastView = self.imageViews.popLast()!
        lastView.image = UIImage.init(named: self.dataSource.shuffled()[0])
        lastView.frame.origin.y = height * CGFloat(offset * -1)
        self.imageViews.insert(lastView, at: 0)
    }
    
}
