//
//  SlotSound.swift
//  LuckyStrike
//
//  Created by TreineticMacbook003 on 8/7/19.
//  Copyright © 2019 TreineticMacbook003. All rights reserved.
//

import Foundation
import AVFoundation
class SlotSound{
    
    static var audioPlayer = AVAudioPlayer()
    
    static func playSound(type: Int){
        var soundName : String!
        switch type {
        case 1:
            soundName = "strike_button_sound"
        default:
            soundName = "strike_button_sound"
        }
        let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: soundName, ofType: "wav")!)
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
        audioPlayer.play()
    }
    
}
