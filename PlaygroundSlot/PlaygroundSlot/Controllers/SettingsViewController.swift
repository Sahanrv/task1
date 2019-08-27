//
//  SettingsViewController.swift
//  PlaygroundSlot
//
//  Created by TreineticMacbook003 on 8/9/19.
//  Copyright © 2019 TreineticMacbook003. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var play_btn: UIButton!
    @IBOutlet weak var mute_btn: UIButton!
    
    
    @IBOutlet weak var playerName: UIButton!
    
    static var isSoundPlay : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setPlayerPanel()
        setSoundButtons()
        
    }
    

    
    @IBAction func didClickBack(_ sender: Any) {
        performSegue(withIdentifier: "backToHome", sender: nil)
    }
    
    @IBAction func didClickPlaySound(_ sender: Any) {
        Sounds.audioPlayer.numberOfLoops = 100
        Sounds.audioPlayer.play()
        SettingsViewController.isSoundPlay = true
        setSoundButtons()
    
    }
    @IBAction func updateName(_ sender: Any) {
        performSegue(withIdentifier: "goToPlayerName", sender: nil)
    }
    
    @IBAction func didClickMuteSound(_ sender: Any) {
        Sounds.audioPlayer.pause()
        SettingsViewController.isSoundPlay = false
        setSoundButtons()
    }
    func setPlayerPanel(){
        playerName.setTitle(UserDefaults.standard.string(forKey: "playerName"), for: .normal)
    }
    
    func setSoundButtons(){
        if(SettingsViewController.isSoundPlay){
            play_btn.setImage(UIImage.init(named : "sound_btn"), for: .normal)
            mute_btn.setImage(UIImage.init(named : "sound_mute_btn_disabled"), for: .normal)
            
        }else{
            play_btn.setImage(UIImage.init(named : "sound_btn_disabled"), for: .normal)
            mute_btn.setImage(UIImage.init(named : "sound_mute_btn"), for: .normal)
        }
    }
    
}
