//
//  Player.swift
//  PlaygroundSlot
//
//  Created by TreineticMacbook003 on 8/13/19.
//  Copyright © 2019 TreineticMacbook003. All rights reserved.
//

import Foundation
class Player {
    
    var point : Int!
    var name : String!
    var image : String!
    
    static var botNames = ["John","Adam","Ben"]
    static var playerImages = ["bot2","bot3","bot4"]
    
    var selectedItem : Item? {
        didSet {
            guard let item = self.selectedItem else {
                return
            }
            
            self.point -= item.value
            
        }
    }
    var isHuman = false
    var isWinner = false
    
    init(withName name : String, point: Int = 2500, isHuman : Bool = false) {
        self.name = name
        self.point = point
        self.isHuman = isHuman
    }
    
    init(withName name : String, image : String, point: Int = 2500, isHuman : Bool = false) {
        self.name = name
        self.image = image
        self.point = point
        self.isHuman = isHuman
    }
    
    func isWinner(item : Item) -> Bool {
        self.isWinner = selectedItem == nil ? false : selectedItem?.value == item.value
        print("isWinner")
        
        calculatePoints(item: item)
        
        
        return isWinner
    }
    
    func calculatePoints(item : Item){
        var botsValue : Int! = 0
        for x in PlayerNameViewController.game.bots{
            botsValue +=  x.selectedItem!.value
        }
        //self.point = point + item.value * 4 + botsValue
    }
    
    func reset() {
        self.isWinner = false
        self.selectedItem = nil
    }
    
    static func random() -> Player {
        botNames = Player.botNames.shuffled()
        playerImages = Player.playerImages.shuffled()
        print("pName : \(botNames)")
        print("pImage : \(playerImages)")
        return Player.init(withName: botNames.popLast()!, image: playerImages.popLast()!)
    }
}
