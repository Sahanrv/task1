//
//  Sounds.swift
//  PlaygroundSlot
//
//  Created by TreineticMacbook003 on 8/9/19.
//  Copyright © 2019 TreineticMacbook003. All rights reserved.
//

import Foundation
import AVFoundation
class Sounds{
    
    static var audioPlayer = AVAudioPlayer()
    static var leverPullSound = AVAudioPlayer()
    static var itemPickSound = AVAudioPlayer()
    static var slotMachineSound = AVAudioPlayer()
    static var winnerSound = AVAudioPlayer()
    static var tryAgainSound = AVAudioPlayer()
    
    static func playSound(type: Int){
        var soundName : String!
        switch type {
        case 1:
            soundName = "background_sound"
            let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: soundName, ofType: "mp3")!)
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            } catch _ {
            }
            do {
                try AVAudioSession.sharedInstance().setActive(true)
            } catch _ {
            }
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: alertSound)
            } catch _{
            }
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = 100
            audioPlayer.volume = 0.3
            audioPlayer.play()
        case 2:
            soundName = "lever_pull"
            let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: soundName, ofType: "mp3")!)
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            } catch _ {
            }
            do {
                try AVAudioSession.sharedInstance().setActive(true)
            } catch _ {
            }
            do {
                leverPullSound = try AVAudioPlayer(contentsOf: alertSound)
            } catch _{
            }
            leverPullSound.prepareToPlay()
            leverPullSound.play()
            
        case 3:
            soundName = "item_pick"
            let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: soundName, ofType: "mp3")!)
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            } catch _ {
            }
            do {
                try AVAudioSession.sharedInstance().setActive(true)
            } catch _ {
            }
            do {
                itemPickSound = try AVAudioPlayer(contentsOf: alertSound)
            } catch _{
            }
            itemPickSound.prepareToPlay()
            itemPickSound.play()
        
        case 4:
            soundName = "slot_machine"
            let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: soundName, ofType: "mp3")!)
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            } catch _ {
            }
            do {
                try AVAudioSession.sharedInstance().setActive(true)
            } catch _ {
            }
            do {
                slotMachineSound = try AVAudioPlayer(contentsOf: alertSound)
            } catch _{
            }
            slotMachineSound.prepareToPlay()
            slotMachineSound.play()
            
        case 5:
            soundName = "winner"
            let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: soundName, ofType: "mp3")!)
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            } catch _ {
            }
            do {
                try AVAudioSession.sharedInstance().setActive(true)
            } catch _ {
            }
            do {
                winnerSound = try AVAudioPlayer(contentsOf: alertSound)
            } catch _{
            }
            winnerSound.prepareToPlay()
            winnerSound.play()
            
            
        case 6:
            soundName = "try_again"
            let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: soundName, ofType: "mp3")!)
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            } catch _ {
            }
            do {
                try AVAudioSession.sharedInstance().setActive(true)
            } catch _ {
            }
            do {
                tryAgainSound = try AVAudioPlayer(contentsOf: alertSound)
            } catch _{
            }
            tryAgainSound.prepareToPlay()
            tryAgainSound.play()
        default:
            soundName = "background_sound"
        }
        
    }
    
    static func playGameSound(sound : AVAudioPlayer,soundName : String,volume : Float){
        
    }
    
}
