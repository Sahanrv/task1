//
//  Main_Vc.swift
//  FourWeelSlot
//
//  Created by Treinetic Macbook 001 on 8/2/19.
//  Copyright © 2019 Treinetic Macbook 001. All rights reserved.
//

import UIKit
import AVFoundation


class Main_Vc: UIViewController {

    @IBOutlet weak var slot1: Slot!
    @IBOutlet weak var slot2: Slot!
    @IBOutlet weak var slot3: Slot!
    @IBOutlet weak var btnStartGame: UIButton!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var winLbl: UILabel!
    @IBOutlet weak var lossLbl: UILabel!
    
    var isRunning = false
    var result1: String!
    var result2: String!
    var result3: String!
    
    var res1: String!
    var res2: String!
    var res3: String!{
        didSet{
            getResults()
        }
    }
    var status: String!
    var filtered: [String]!
    
    let addWinPoints = 50
    let addPoints = 25
    var points = 0
    var winPercentage = 0.0
    var lossPercentage = 0.0
    var audioPlayer:AVAudioPlayer!
    var audioFilePath = Bundle.main.path(forResource: "audio", ofType: ".mp3")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uIConfig()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        let imgArray = [
//            Item(value: "1", it: "1"),
//            Item(value: "2", it: "2"),
//            Item(value: "3", it: "3"),
//            Item(value: "4", it: "4"),
//            Item(value: "5", it: "5"),
//            Item(value: "6", it: "6"),
//            Item(value: "7", it: "7"),
//            Item(value: "8", it: "8"),
//        ]
        
        let imgArray = [
            Item(value: "1", it: "1"),
            Item(value: "2", it: "2"),
            Item(value: "3", it: "3"),
            Item(value: "4", it: "4"),
            Item(value: "3", it: "3"),
            Item(value: "3", it: "3"),
            Item(value: "3", it: "3"),
            Item(value: "6", it: "6"),
        ]
        
        slot1.viewType = .image
        slot2.viewType = .image
        slot2.isReverse = true
        slot3.viewType = .image
        
        slot1.initializeViews(dataSource: imgArray)
        slot2.initializeViews(dataSource: imgArray)
        slot3.initializeViews(dataSource: imgArray)
    }
    
    func uIConfig(){
        self.btnStartGame.layer.cornerRadius = self.btnStartGame.bounds.height / 2
        self.btnStartGame.clipsToBounds = true
    }
    
    @IBAction func didClickStartGame(_ sender: Any) {
        
            self.didButtonClickSound()
        
            self.btnStartGame.isEnabled = false
        
            let timeStop  = Int.random(in: 4...10 )
        
            self.result1 = String(Int.random(in: 1 ... 6))
        
            slot1.animate(finalValue: Item(value: self.result1, it: self.result1), times: timeStop, speed: 0.7, completion: {
                print("slot 1 ", self.slot1.finalValue!.value!)
                self.res1 = self.slot1.finalValue!.value
            
            })
            self.result2 = String(Int.random(in: 1 ... 6))
        
            slot2.animate(finalValue: Item(value: self.result2, it: self.result2), times: timeStop, speed: 0.7, completion: {
                print("slot 2 ", self.slot2.finalValue!.value!)
                 self.res2 = self.slot2.finalValue!.value

            })
            self.result3 = String(Int.random(in: 1 ... 6))
        
            slot3.animate(finalValue:  Item(value: self.result3, it: self.result3), times: timeStop, speed: 0.7, completion: {
                print("slot 3 ", self.slot3.finalValue!.value!)
                self.res3 = self.slot3.finalValue!.value

            })
        
    }
    
    func didButtonClickSound(){
        
        
        if audioFilePath != nil {
            let audioFileUrl = NSURL.fileURL(withPath: audioFilePath!)
            audioPlayer = try?AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: nil)
        } else {
            print("audio file is not found")
        }
        if audioFilePath != nil {
            audioPlayer.play()
        }
    }
    
    
    func getResults(){
        
        self.btnStartGame.isEnabled = true
        print(self.res1!, self.res2!, self.res3!)
        
        let array: [String] = [self.res1, self.res2, self.res3]
        
        let value = getArrayDublicateCount(arrayNew: array)
        
        print("Result Count :", value)
        
        if res1 == res2 && res2 == res3 {
        print("Win")
        self.status = "Win"
        winPoint(point: 1.0)
            
        }
        else {
            
            if value == 2 {
                winPoint(point: 0.5)
            }else{
                 lossPoint(point: 0.5)
            }
        print("Try Again")
        self.status = "Try Again"
            
        }
    }
    
    
    func getArrayDublicateCount (arrayNew: [String]) -> Int {
     
        var max = 0
        
        for i in 0...arrayNew.count - 1 {
            filtered = arrayNew.filter { (x) -> Bool in
                
                x == arrayNew[i]
            }
            // Display results.
            print(filtered!)
            print(filtered.count)
            
            if max < filtered.count{
                max = filtered.count
            }
            
        }
            return max
    }
    
    func winPoint(point: Double!){
        
        if point == 1 {
            self.points = self.points + self.addWinPoints
            self.winPercentage = self.winPercentage + point
            self.pointLabel.text = String(points)
            self.winLbl.text = String(winPercentage)
            
        }else{
            
            self.points = self.points + addPoints
            self.winPercentage = self.winPercentage + point
            self.pointLabel.text = String(points)
            self.winLbl.text = String(winPercentage)
        }
    }
    
    func lossPoint(point: Double!){
            self.lossPercentage = self.lossPercentage + point
            self.lossLbl.text = String(lossPercentage)
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
