//
//  PlayViewController.swift
//  PlaygroundSlot
//
//  Created by TreineticMacbook003 on 8/12/19.
//  Copyright © 2019 TreineticMacbook003. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {

    
    @IBOutlet weak var slot1: Slot!
    @IBOutlet weak var slot2: Slot!
    @IBOutlet weak var slot3: Slot!
    @IBOutlet weak var slot4: Slot!
    
    var isRunning = false
    
    var imgArray = [Item]()
    var playerImages = [String]()
    var botNames = [String]()
    
    var slotItem1 = Item()
    var slotItem2 = Item()
    var slotItem3 = Item()
    var slotItem4 = Item()
    
    @IBOutlet weak var itemView1: ItemView!
    @IBOutlet weak var itemView2: ItemView!
    @IBOutlet weak var itemView3: ItemView!
    @IBOutlet weak var itemView4: ItemView!
    
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var botPlayer1: BotPlayerView!
    @IBOutlet weak var botPlayer2: BotPlayerView!
    @IBOutlet weak var botPlayer3: BotPlayerView!
    
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerItemImage: UIImageView!
    @IBOutlet weak var playerNameText: UILabel!
    @IBOutlet weak var playerPoints: UILabel!
    
    static var playerName : String = UserDefaults.standard.string(forKey: "playerName")!
    
    @IBOutlet weak var slot_lever_btn: UIButton!
    
    static let human = Player.init(withName: playerName , isHuman: true)
    
    var bot1 : Player!
    var bot2 : Player!
    var bot3 : Player!
    
    var rounds : Int = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setItemPanel()
        setPlayerPanel()
        
        PlayerNameViewController.game.add(Player: PlayViewController.human)
        PlayerNameViewController.game.initialize()
        setBotPlayersPanel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        itemView1.blink()
        itemView2.blink()
        itemView3.blink()
        itemView4.blink()
        
        
        imgArray = [
            Item(value: 100, it: "cricket"),
            Item(value: 200, it: "baseball"),
            Item(value: 300, it: "american_football"),
            Item(value: 400, it: "football")
        ]
        
        PlayerNameViewController.game.items = imgArray
        
        slot1.viewType = .image
        slot2.viewType = .image
        slot2.isReverse = true
        slot3.viewType = .image
        slot4.viewType = .image
        slot4.isReverse = true
        
        DispatchQueue.main.async {
            self.slot1.initializeViews(dataSource: self.imgArray)
            self.slot2.initializeViews(dataSource: self.imgArray)
            self.slot3.initializeViews(dataSource: self.imgArray)
            self.slot4.initializeViews(dataSource: self.imgArray)
        }
    
           itemView1.selectItem = {
                
                if(PlayViewController.human.selectedItem == nil){
                    self.playItemPickSound()
                    self.removeItemAnimation()
                    self.setSelectedItemStyle(itemView: self.itemView1)
                    PlayerNameViewController.game.selectItem(item: self.imgArray[0], player: PlayViewController.human)
                    self.playerItemImage.image = UIImage.init(named: (PlayerNameViewController.game.human?.selectedItem?.it!)!)
                    self.playerPoints.text = "\(PlayerNameViewController.game.human!.point!)"
                    self.setBotItems()
                }
            }
            itemView2.selectItem = {
                if(PlayViewController.human.selectedItem == nil){
                    self.playItemPickSound()
                    self.removeItemAnimation()
                    self.setSelectedItemStyle(itemView: self.itemView2)
                    PlayerNameViewController.game.selectItem(item: self.imgArray[1], player: PlayViewController.human)
                    self.playerItemImage.image = UIImage.init(named: (PlayerNameViewController.game.human?.selectedItem?.it!)!)
                    self.playerPoints.text = "\(PlayerNameViewController.game.human!.point!)"
                    self.setBotItems()
                }
            }
            itemView3.selectItem = {
                if(PlayViewController.human.selectedItem == nil){
                    self.playItemPickSound()
                    self.removeItemAnimation()
                    self.setSelectedItemStyle(itemView: self.itemView3)
                    PlayerNameViewController.game.selectItem(item: self.imgArray[2], player: PlayViewController.human)
                    self.playerItemImage.image = UIImage.init(named: (PlayerNameViewController.game.human?.selectedItem?.it!)!)
                    self.playerPoints.text = "\(PlayerNameViewController.game.human!.point!)"
                    self.setBotItems()
                }
            }
            itemView4.selectItem = {
                if(PlayViewController.human.selectedItem == nil){
                    self.playItemPickSound()
                    self.removeItemAnimation()
                    self.setSelectedItemStyle(itemView: self.itemView4)
                    PlayerNameViewController.game.selectItem(item: self.imgArray[3], player: PlayViewController.human)
                    self.playerItemImage.image = UIImage.init(named: (PlayerNameViewController.game.human?.selectedItem?.it!)!)
                    self.playerPoints.text = "\(PlayerNameViewController.game.human!.point!)"
                    self.setBotItems()
                }
            }
        
    }
    
    func setItemPanel(){
       
        itemView1.itemImage.image = UIImage.init(named: "cricket")
        itemView1.itemPoints.text = "100"
        itemView2.itemImage.image = UIImage.init(named: "baseball")
        itemView2.itemPoints.text = "200"
        itemView3.itemImage.image = UIImage.init(named: "american_football")
        itemView3.itemPoints.text = "300"
        itemView4.itemImage.image = UIImage.init(named: "football")
        itemView4.itemPoints.text = "400"
       
    }
    func removeItemAnimation(){
        itemView1.layer.removeAllAnimations()
        itemView2.layer.removeAllAnimations()
        itemView3.layer.removeAllAnimations()
        itemView4.layer.removeAllAnimations()
    }
    
    func setPlayerPanel(){
        playerNameText.text = UserDefaults.standard.string(forKey: "playerName")
        playerPoints.text = "\(PlayViewController.human.point!)"
        
    }
    
    func setBotPlayersPanel(){
        
        botPlayer1.playerName.text = PlayerNameViewController.game.bots[0].name
        botPlayer1.playerImage.image = UIImage.init(named: PlayerNameViewController.game.bots[0].image)
        botPlayer1.playerPoints.text = "\(PlayerNameViewController.game.bots[0].point!)"
        
        botPlayer2.playerName.text = PlayerNameViewController.game.bots[1].name
        botPlayer2.playerImage.image = UIImage.init(named: PlayerNameViewController.game.bots[1].image)
        botPlayer2.playerPoints.text = "\(PlayerNameViewController.game.bots[1].point!)"
        
        botPlayer3.playerName.text = PlayerNameViewController.game.bots[2].name
        botPlayer3.playerImage.image = UIImage.init(named: PlayerNameViewController.game.bots[2].image)
        botPlayer3.playerPoints.text = "\(PlayerNameViewController.game.bots[2].point!)"
        
       
    }
    func setBotItems(){
        
            botPlayer1.playerItem.image = UIImage.init(named: PlayerNameViewController.game.bots[0].selectedItem!.it )
            botPlayer1.playerPoints.text = "\(PlayerNameViewController.game.bots[0].point!)"
            botPlayer2.playerItem.image = UIImage.init(named: PlayerNameViewController.game.bots[1].selectedItem!.it )
            botPlayer2.playerPoints.text = "\(PlayerNameViewController.game.bots[1].point!)"
            botPlayer3.playerItem.image = UIImage.init(named: PlayerNameViewController.game.bots[2].selectedItem!.it )
            botPlayer3.playerPoints.text = "\(PlayerNameViewController.game.bots[2].point!)"
        
    }
    
    func setSelectedItemStyle(itemView : UIView){
        itemView.layer.borderWidth = 2
        itemView.layer.borderColor = UIColor(named: "secondary")?.cgColor
        
    }
    func removeSelectedItemStyle(){
        itemView1.layer.borderWidth = 0
        itemView2.layer.borderWidth = 0
        itemView3.layer.borderWidth = 0
        itemView4.layer.borderWidth = 0
        
    }
    
    private func pullAnimation(delay : Double){
        UIView.animate(withDuration: delay, animations: {() -> Void in
            self.slot_lever_btn?.transform = CGAffineTransform(scaleX: 1, y: 0.6)
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: delay, animations: {() -> Void in
                self.slot_lever_btn?.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        })
    }
    
    func findWinner(){
        rounds = rounds - 1
        
        if(rounds == 0){
            print("************")
            print("Getting Winner")
            
            let slotArray : [Item] = [slotItem1,slotItem2,slotItem3,slotItem4]
            
            PlayerNameViewController.game.getWinner(slotItems : slotArray)
            rounds = 4
            PlayViewController.human.selectedItem = nil
            setPlayerPanel()
            setBotItems()
            removeSelectedItemStyle()
        }
    }
    func playItemPickSound(){
        Sounds.playSound(type: 3)
        Sounds.itemPickSound.play()
    }
    func playSlotMachineSound(){
        Sounds.playSound(type: 4)
        Sounds.slotMachineSound.play()
    }
   
    @IBAction func didClickLeverPull(_ sender: Any) {
        
        if(PlayViewController.human.selectedItem != nil){
            Sounds.playSound(type: 2)
            pullAnimation(delay: 0.4)
            
            slotItem1 =  imgArray.shuffled()[0]
            slotItem2 =  imgArray.shuffled()[0]
            slotItem3 =  imgArray.shuffled()[0]
            slotItem4 =  imgArray.shuffled()[0]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.playSlotMachineSound()
                self.slot1.animate(finalValue: self.slotItem1, times: 10, speed: 0.8, completion: {
                    print("slot 1 ", self.slot1.finalValue?.value as Any)
                    Sounds.slotMachineSound.stop()
                    self.findWinner()
                })
                self.slot2.animate(finalValue: self.slotItem2, times: 12, speed: 0.6, completion: {
                    print("slot 2 ", self.slot2.finalValue?.value as Any)
                    self.findWinner()
                })
                self.slot3.animate(finalValue:  self.slotItem3, times: 18, speed: 0.4, completion: {
                    print("slot 3 ", self.slot3.finalValue?.value as Any)
                    self.findWinner()
                })
                self.slot4.animate(finalValue:  self.slotItem4, times: 18, speed: 0.4, completion: {
                    print("slot 4 ", self.slot4.finalValue?.value as Any)
                    self.findWinner()
                })
            
            })
            
        }
    }
    
    @IBAction func didClickBack(_ sender: Any) {
        
        PlayerNameViewController.game.reset()
        performSegue(withIdentifier: "backToHome", sender: nil)
    }
    
}
extension UIView {
    func blink() {
        self.alpha = 0.0;
        UIView.animate(withDuration: 0.5, //Time duration you want,
            delay: 0.0,
            options: [.curveEaseInOut, .autoreverse, .repeat],
            animations: { [weak self] in self?.alpha = 1.0 },
            completion: { [weak self] _ in self?.alpha = 0.0 })
    }
}
