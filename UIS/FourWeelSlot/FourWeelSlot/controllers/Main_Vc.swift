//
//  Main_Vc.swift
//  FourWeelSlot
//
//  Created by Treinetic Macbook 001 on 8/2/19.
//  Copyright © 2019 Treinetic Macbook 001. All rights reserved.
//

import UIKit

class Main_Vc: UIViewController {

    @IBOutlet weak var slot1: Slot!
    @IBOutlet weak var slot2: Slot!
    @IBOutlet weak var slot3: Slot!
    var isRunning = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let imgArray = [
            Item(value: "c1", it: "1"),
            Item(value: "c2", it: "2"),
            Item(value: "c3", it: "3"),
            Item(value: "c1", it: "1"),
            Item(value: "c2", it: "2"),
            Item(value: "c3", it: "3"),
            Item(value: "c1", it: "1"),
            Item(value: "c2", it: "2"),
            Item(value: "c3", it: "3")
        ]
        
        slot1.viewType = .image
        slot2.viewType = .image
        slot2.isReverse = true
        slot3.viewType = .image
        
        slot1.initializeViews(dataSource: imgArray)
        slot2.initializeViews(dataSource: imgArray)
        slot3.initializeViews(dataSource: imgArray)
    }
    
    @IBAction func didClickStartGame(_ sender: Any) {
        
        if !isRunning {
            slot1.animate(finalValue: Item(value: "c3", it: "2"), times: Int.max, speed: 0.7, completion: {
                print("slot 1 ", self.slot1.finalValue?.value)
            })
            slot2.animate(finalValue: Item(value: "c3", it: "2"), times: Int.max, speed: 0.7, completion: {
                print("slot 2 ", self.slot2.finalValue?.value)
            })
            slot3.animate(finalValue:  Item(value: "c3", it: "2"), times: Int.max, speed: 0.7, completion: {
                print("slot 3 ", self.slot3.finalValue?.value)
            })
        }else{
            slot1.stop()
            slot2.stop()
            slot3.stop()
            
        }
        isRunning = !isRunning
    
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
