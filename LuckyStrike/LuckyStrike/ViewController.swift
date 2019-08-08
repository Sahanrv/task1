//
//  ViewController.swift
//  LuckyStrike
//
//  Created by TreineticMacbook003 on 8/2/19.
//  Copyright © 2019 TreineticMacbook003. All rights reserved.
//

import UIKit
import SwiftEntryKit
class ViewController: UIViewController{
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var slotBackground: UIView!
    @IBOutlet weak var betBackground: UIView!
    @IBOutlet weak var textPoints: UILabel!
    @IBOutlet weak var textBetAmount: UILabel!
    
    @IBOutlet weak var btnStrike: UIButton!

    let dataArray = ["A","B","C","$"]
    var slotArray = [[SlotItem]]()
    
    var animateArray = [SlotItem]()
    
    var points : Int! = 1000
    var betAmount : Int = 10
    
    let goldBorder = [
        0 : [0, 2],
        1 : [1],
        2 : [0, 2]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSlotMachine()
    }
    
    func setSlotMachine(){
        textPoints.text = "\(points!)"
        
        let size = 2
        for x in 0...size {
            let innerStack = UIStackView()
            innerStack.spacing = 5
            innerStack.distribution = .fillEqually
            innerStack.axis = .horizontal
            var sArray = [SlotItem]()
            
            for y in 0...size {
                let sItem = SlotItem()
                
                if goldBorder[x]!.contains(y) {
                    sItem.borderColor = Colors.secondary
                }else{
                    sItem.borderColor = Colors.primary
                }
                sItem.text = dataArray.shuffled()[0]
                sArray.append(sItem)
                
                animateArray.append(sItem)
                
                innerStack.addArrangedSubview(sItem)
                
            }
            self.slotArray.append(sArray)
            self.stackView.addArrangedSubview(innerStack)
        }
    }
    
    func calculateWinner () {
        //check for cross
        var temp = [SlotItem]()
        for (k, x) in self.goldBorder {
            for y in x {
                temp.append(slotArray[k][y])
            }
        }
        
        if Set(temp.map({$0.text})).count == 1 {
            
            
            if(Set(temp.map({$0.text})).contains("$")){
                print("full array")
                showGradiants(sItems: temp)
                addWinPoints(Multiply: 4)
                btnStrike.isEnabled = false
                showModalWin()
            }
            
            
            return
        }
        
        temp = [SlotItem]()
        for x in 0...2 {
            temp.append(slotArray[x][x])
        }
        
        if Set(temp.map({$0.text})).count == 1 {
            if(Set(temp.map({$0.text})).contains("$")){
                print("half array")
                showGradiants(sItems: temp)
                addWinPoints(Multiply: 2)
                btnStrike.isEnabled = false
                showModalWin()
            }
            
            return
        }
        
        temp = [SlotItem]()
        for x in (0...2).reversed() {
            temp.append(slotArray[x][x])
        }
        
        if Set(temp.map({$0.text})).count == 1 {
            if(Set(temp.map({$0.text})).contains("$")){
                print("half array")
                showGradiants(sItems: temp)
                addWinPoints(Multiply: 2)
                btnStrike.isEnabled = false
                showModalWin()
            }
            return
        }
        
        else{
            
            if(points > betAmount){
                betAmount = Int.init(textBetAmount.text!)!
                points = points - betAmount
                print("\(points!)")
                print("Reduced Bet - \(betAmount)")
                textPoints.text =  "\(points!)"
            
            }else{
                btnStrike.isEnabled = false
                textPoints.text =  "0"
                textBetAmount.text =  "0"
                showModalTryAgian()
            }
        }
    }
    
    func addWinPoints(Multiply : Int){
        betAmount = Int.init(textBetAmount.text!)! * Multiply
        print("before \(points!)")
        points = points + betAmount
        textPoints.text =  "\(points!)"
        print("win \(points!)")
        textPoints.text =  "\(points!)"

    }
    
    var gradiants = [CAGradientLayer]()
    
    func showGradiants(sItems : [SlotItem]) {
        sItems.forEach({$0.isGradiantShow = true})
        
    }
    
    func hideGradiants() {
        self.slotArray.forEach { (i) in
            i.forEach({$0.isGradiantShow = false})
        }
    }
    
    func showModalWin(){
        let modalWinView = ModalWin()
        
        modalWinView.closeModal = {
            SwiftEntryKit.dismiss()
            self.btnStrike.isEnabled = true
            self.hideGradiants()
           
        }
        var attributes = EKAttributes()
        attributes.roundCorners = .all(radius: 50)
        attributes.border = .value(color: .white, width: 1)
        attributes.displayDuration = .infinity
        attributes.position = .center
        attributes.entranceAnimation = .init(translate: .none,
                                             scale: .init(from: 0, to: 1, duration: 0.4),
                                             fade: .init(from: 0, to: 1, duration: 0.4))
        attributes.shadow = .active(with: .init(color: .black, opacity: 1, radius: 10, offset: .zero))
        attributes.scroll = .disabled
        attributes.entryBackground = .color(color: .yellow)
        attributes.screenBackground = .color(color: (UIColor(white: 0.5, alpha: 0.5)))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.2)))
        
        attributes.entryInteraction = .absorbTouches
        SwiftEntryKit.display(entry: modalWinView, using: attributes)
    }
    func showModalTryAgian(){
        let modalTryView = ModalTryAgain()
        
        modalTryView.closeModal = {
            SwiftEntryKit.dismiss()
            self.btnStrike.isEnabled = true
            self.points = 1000
            self.textPoints.text = "\(self.points!)"
            self.betAmount = 10
            self.textBetAmount.text = "\(self.betAmount)"
            //self.setSlotMachine()
        }
        var attributes = EKAttributes()
        attributes.roundCorners = .all(radius: 50)
        attributes.border = .value(color: .white, width: 1)
        
        attributes.displayDuration = .infinity
        attributes.position = .center
        attributes.entranceAnimation = .init(translate: .none,
                                             scale: .init(from: 0, to: 1, duration: 0.4),
                                             fade: .init(from: 0, to: 1, duration: 0.4))
        attributes.shadow = .active(with: .init(color: .black, opacity: 1, radius: 10, offset: .zero))
        attributes.scroll = .disabled
        attributes.entryBackground = .color(color: .yellow)
        attributes.screenBackground = .color(color: (UIColor(white: 0.5, alpha: 0.5)))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.2)))
        attributes.entryInteraction = .absorbTouches
        SwiftEntryKit.display(entry: modalTryView, using: attributes)
    }

    @IBAction func didClickHowToPlay(_ sender: Any) {
        performSegue(withIdentifier: "howtoplay", sender: nil)
    }
    

    @IBAction func didClickIncreaseBet(_ sender: Any) {
        if(betAmount >= points){
            
        }else{
            betAmount = betAmount + 10
            textBetAmount.text = "\(betAmount)"
        }
    }
    
    
    @IBAction func didClickDecreaseBet(_ sender: Any) {
        if(betAmount <= 10 ){
            
        }else{
            betAmount = betAmount - 10
            textBetAmount.text = "\(betAmount)"
        }
    }
    
    @IBAction func didClickStrike(_ sender: Any) {
        SlotSound.playSound(type :1)
       
        for x in animateArray {
            UIView.animate(withDuration: 0.1,
                           animations: {
                            x.outterView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                           completion: { _ in
                            UIView.animate(withDuration: 0.1) {
                                x.outterView.transform = CGAffineTransform.identity
                            }
            })
        
        }
        
        for x in slotArray {
            for y in x {
                y.text = dataArray.shuffled()[0]
            }
        }
        
        calculateWinner()
        
    }
    
}


