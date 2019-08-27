//
//  Game.swift
//  PlaygroundSlot
//
//  Created by TreineticMacbook003 on 8/13/19.
//  Copyright © 2019 TreineticMacbook003. All rights reserved.
//

import UIKit
class Game {
    static let playerCount = 4
    static let itemCount = 4
    
    var players = [Player]()
    var items = [Item]()
    var slotItems = [Item]()
    
    var winner : Player?
    
    var human : Player? {
        return players.first(where: {$0.isHuman})
    }
    
    var bots : [Player] {
        return players.filter({ !$0.isHuman })
    }
    
    func add(Player player : Player) {
        self.players.append(player)
    }
    
    func initialize() {
        for _ in 0 ..< (Game.playerCount - self.players.count) {
            self.add(Player: Player.random())
        }
        //items = Item.getList()
    }
    
    func selectItem(item : Item, player : Player) {
        player.selectedItem = item
        print("Items : \(items)"  )
        var availableItems = self.items.filter({$0.it != item.it}).shuffled()
        print("availableItems : \(availableItems)"  )
        for bot in self.bots {
            bot.selectedItem = availableItems.popLast()
            print(bot.name,bot.selectedItem?.it)
        }
        print(player.selectedItem?.value)
    }
    
    func spin() {
        self.slotItems = [Item]()
        for _ in self.items {
            self.slotItems.append(self.items.shuffled()[0])
        }
        //self.winner = getWinner()
    }
    
    func getWinner(slotItems : [Item]) -> Player? {
        
        var counts: [Item: Int] = [:]
        for item in slotItems{
            counts[item] = (counts[item] ?? 0) + 1
        }
        
        
        for (key, value) in counts {
            print("\(key.it!) occurs \(value) time(s)")
            
            if(key.it == players[0].selectedItem?.it){
                print(players[0].name)
                checkOccurance(value: value, player: players[0] )
                
            }else if(key.it == players[1].selectedItem?.it){
                print("\(players[1].name)")
                checkOccurance(value: value, player: players[1] )
                
            }else if(key.it == players[2].selectedItem?.it){
                print("\(players[2].name)")
                checkOccurance(value: value, player: players[2] )
                
            }else if(key.it == players[3].selectedItem?.it){
                print("\(players[3].name)")
                checkOccurance(value: value, player: players[3] )
                
            }
            
        }
        
        for x in PlayerNameViewController.game.players{
            if(x.point < 400){
              x.point = 2500
            }
        }
                
        for player in self.players {
            if player.isWinner(item: slotItems[0]) {
                print(player.name)
                return player
            }
        }
        return nil
    }
    
    func checkOccurance(value : Int, player : Player){
        if(value == 1){
            print("1 time \(player.name):\(player.isHuman)")
        }
        if(value == 2){
            print("2 time \(player.name):\(player.isHuman)")
            player.point += player.selectedItem!.value * 2
            if(player.isHuman){
                print("\(player.name) win")
                Sounds.playSound(type: 5)
                Sounds.winnerSound.play()
            }else{
                Sounds.playSound(type: 6)
                Sounds.tryAgainSound.play()
            }
        }
        if(value == 3){
            print("3 time \(player.name):\(player.isHuman)")
            player.point += player.selectedItem!.value * 3
            if(player.isHuman){
                print("\(player.name) win")
                Sounds.playSound(type: 5)
                Sounds.winnerSound.play()
            }else{
                Sounds.playSound(type: 6)
                Sounds.tryAgainSound.play()
            }
            
        }
        if(value == 4){
            print("4 time \(player.name):\(player.isHuman)")
            player.point += player.selectedItem!.value * 4
            if(player.isHuman){
                print("\(player.name) win")
                Sounds.playSound(type: 5)
                Sounds.winnerSound.play()
            }else{
                Sounds.playSound(type: 6)
                Sounds.tryAgainSound.play()
            }
        }
    }
    
    func reset() {
        self.slotItems = [Item]()
        self.players.forEach({
            $0.reset()
        })
    }
    
    
}



