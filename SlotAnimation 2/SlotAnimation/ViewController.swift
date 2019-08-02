//
//  ViewController.swift
//  SlotAnimation
//
//  Created by Treinetic Mackbook 005 on 7/30/19.
//  Copyright © 2019 Treinetic Mackbook 005. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slot3: Slot!
    @IBOutlet weak var slot2: Slot!
    @IBOutlet weak var slot: Slot!
    
    var isRunning = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        slot.initializeView()
        slot2.isReversed = true
        slot2.initializeView()
        slot3.initializeView()
    }
    
    @IBAction func didClickInf(_ sender: Any) {
        if !isRunning {
            slot.animate(finalValue: "8", times: Int.max, speed: 0.7, callback: {
                print("slot end ", self.slot.finalValue)
            })
            slot2.animate(finalValue: "5", times: Int.max, speed: 0.5, callback: {
                print("slot2 end ", self.slot2.finalValue)
            })
            slot3.animate(finalValue: "8", times: Int.max, speed: 0.6, callback: {
                print("slot3 end ", self.slot3.finalValue)
            })
        }else{
            slot.stop()
            slot2.stop()
            slot3.stop()
        }
        
        isRunning = !isRunning
        
        
    }
    
    
    @IBAction func didClick(_ sender: Any) {
        slot.animate(finalValue: "8", times: 10, speed: 0.7, callback: nil)
        slot2.animate(finalValue: "5", times: 7, speed: 0.5, callback: nil)
        slot3.animate(finalValue: "8", times: 12, speed: 0.6, callback: nil)
    }
    

}

