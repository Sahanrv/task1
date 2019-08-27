//
//  HomeViewController.swift
//  PlaygroundSlot
//
//  Created by TreineticMacbook003 on 8/9/19.
//  Copyright © 2019 TreineticMacbook003. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        if(SettingsViewController.isSoundPlay){
            Sounds.playSound(type: 1)
            Sounds.audioPlayer.play()
        }else{
            Sounds.audioPlayer.pause()
        }
        
    }
    
    func exists(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    @IBAction func didClickSettings(_ sender: Any) {
        performSegue(withIdentifier: "goToSettings", sender:nil)
    }
    
    @IBAction func didClickPlay(_ sender: Any) {
        
        if(exists(key: "playerName")){
            performSegue(withIdentifier: "goToPlay", sender:nil)
        }else{
            performSegue(withIdentifier: "goToPlayerName", sender:nil)
        }
        
        
    }
}
