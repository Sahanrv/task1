//
//  Slot.swift
//  PlaygroundSlot
//
//  Created by TreineticMacbook003 on 8/12/19.
//  Copyright © 2019 TreineticMacbook003. All rights reserved.
//

import Foundation
import UIKit

struct Item : Hashable {
    var value : Int!
    var it : String!
}

class Slot : UIView {
    
    enum ItemType {
        case image
        case text
    }
    
    
    @IBOutlet weak var container: UIImageView!
    
    var slotItemViews = [SlotItem]()
    var dataSource = [Item]()
    var numOfViews = 5
    var padding = CGFloat(0)
    var animationSpeed = 0.4
    var finalValue : Item?
    var viewType : ItemType = .text
    var completionHandler : (() -> Void)?
    var shouldStop = false
    /*
     if reverse set to true. container view will be rotated by 180 degrees to change the direction
     of animation.
     But this make image view rotate also. So all image views needs to rorate 180 degrees again
     to make images display in correct orientation. Otherwise images will be upside down.
     */
    var isReverse : Bool = false {
        didSet {
            if isReverse {
                self.container.transform = CGAffineTransform(rotationAngle: .pi)
                for sItem in self.slotItemViews {
                    sItem.transform = CGAffineTransform(rotationAngle: .pi)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initXib()
    }
    
    private func initXib() {
        let nib = UINib.init(nibName: "Slot", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
}

extension Slot {
    
    /*
     Create initial layout of the images. First need to find how many view needs to go above and below the center view.
     numOfView always needs to be a odd number. So we need to devide it by 2 and floor it. floor will always round the number to lowset values. So 5 / 2 = 2.5. If we round this number using round(2.5) result will be 3. But floor(2.5) will give 2 as the result.
     The run a loop from minus offset value to plus offset value. Eg : if the offset is 2. Loop will run -2 to +2. If the offset is 5. Loop will run -5 to +5. This will make easy to calculate Y position.
     To calculate height of the view. We need to get the parent's height and subtract the (padding * 2). Because we need to add padding to both top and bottom. So multiply padding by 2. If the parents height 100 and the padding 10. image height will be 100 - (10 * 2) = 80.
     To calculate Y position we need to multiply height by loop's iteration value. Eg : If the loop runs -2 to +2. and height of the image is 80. First iteration we will get 80 * -2 = -160. Minus 160 means view will be move above parents view. Second iteration we will get 80 * -1 = -80. Second view also move above the parent view but below the first view. Third iteration is 80 * 0 = 0. So Third view will be inside the parent's view because Y position is 0. But since we have a padding. We need to add padding to the calculation. so (80 * 0) + 10 = 10. So Third view will be center in the view.
     Then add all images views to a array for later reference.
     */
    func initializeViews(dataSource : [Item]) {
        self.dataSource = dataSource
        let offset = Int(floor(Double(self.numOfViews) / 2.0))
        for position in (offset * -1)...offset {
            
            let height = self.container.bounds.height - (padding * 2)
            let width = self.container.bounds.width
            let x = CGFloat(0)
            let y =  (height * CGFloat(position)) + padding
            let rect = CGRect.init(x: x,
                                   y: y,
                                   width: width,
                                   height: height)
            var sItem: SlotItem!
            if self.viewType == .image {
                sItem = ImageSlotItem.init()
            } else if self.viewType == .text {
                sItem = TextSlotItem.init()
            }
            sItem.build(withFrame: rect, item: self.dataSource.shuffled().first!)
            if isReverse {
                sItem.transform = CGAffineTransform(rotationAngle: .pi)
            }
            self.container.addSubview(sItem)
            self.slotItemViews.append(sItem)
        }
    }
    
    func animate(finalValue : Item, times : Int, speed : Double = 0.4, completion : @escaping (() -> Void)) {
        self.animationSpeed = speed
        self.finalValue = finalValue
        self.completionHandler = completion
        self.shouldStop = false
        animate(finalValue: finalValue, loop: times)
    }
    
    /*
     This is a recursive function. This is invoke untill the loop == 0. And each iteration loop will be subtract by 1.
     First call initializeAnimation method to set initial positions for the views.
     If the loop == offset + 1 then set the final value to the first item of the array. Because this item will be in the center at the end of the animation.
     Then animate all view's Y position to += height.
     After animation start a timer with interval of half of the speed. So timer will active when the animation is 50% complete. Optionally we can use animation's completion handler. But animation is not smooth.
     On timer's handler invoke again animate method with subtracted loop value.
     Before return the function we need to invoke the completionHandler set by user to notify the end of the animation.
     
     */
    private func animate(finalValue : Item, loop : Int) {
        if loop <= 0 || shouldStop {
            self.finalValue = self.slotItemViews[Int(floor(Double(self.dataSource.count) / 2.0)) - 1].item
            self.completionHandler?()
            return
        }
        let offset = Int(floor(Double(self.numOfViews) / 2.0))
        let height = self.container.bounds.height - (padding * 2)
        self.initializeAnimation()
        if loop  == offset + 1 {
            self.slotItemViews[0].item = self.finalValue
        }
        UIView.animate(withDuration: animationSpeed, animations: {
            for position in 1..<self.slotItemViews.count {
                self.slotItemViews[position].frame.origin.y += height
                //                 print("animate view ", self.slotItemViews[position].hash,
                //                       "from", self.slotItemViews[position].frame.origin.y - height,
                //                       "to", self.slotItemViews[position].frame.origin.y)
            }
        }) { (result) in
            // completion handler
        }
        Timer.scheduledTimer(withTimeInterval: animationSpeed - (animationSpeed / 2.0), repeats: false) { (t) in
            let next = loop - 1
            self.animate(finalValue: finalValue, loop: next)
        }
    }
    
    /*
     Remove last item from the array.
     Then assign random value to the image.
     Then move image view to the top position.
     Then add same image view to the array as the first item.
     */
    private func initializeAnimation() {
        let offset = Int(floor(Double(self.numOfViews) / 2.0))
        let height = self.container.bounds.height - (padding * 2)
        let lastItem = self.slotItemViews.popLast()!
        lastItem.item = dataSource.shuffled()[0]
        lastItem.frame.origin.y = (height * CGFloat(offset * -1)) + padding
        self.slotItemViews.insert(lastItem, at: 0)
        //        print("move last item to the top")
    }
    
    func stop() {
        self.shouldStop = true
    }
    
}


class SlotItem : UIView {
    
    var item : Item! {
        didSet {
            self.update()
        }
    }
    
    func build(withFrame : CGRect, item : Item) {
        self.item = item
    }
    
    func update() {
        
    }
}

class ImageSlotItem : SlotItem {
    let imageView = UIImageView()
    override func build(withFrame: CGRect, item: Item) {
        super.build(withFrame: withFrame, item: item)
        self.frame = withFrame
        imageView.frame = CGRect.init(x: 0, y: 0, width: withFrame.width, height: withFrame.height)
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
    }
    
    override func update() {
        self.imageView.image = UIImage.init(named: self.item.it)
    }
}

class TextSlotItem : SlotItem {
    let labelView = UILabel()
    override func build(withFrame: CGRect, item: Item) {
        super.build(withFrame: withFrame, item: item)
        self.frame = withFrame
        labelView.frame = CGRect.init(x: 0, y: 0, width: withFrame.width, height: withFrame.height)
        labelView.textAlignment = .center
        addSubview(labelView)
    }
    
    override func update() {
        self.labelView.text = self.item.it
    }
}
