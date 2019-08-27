//
//  PlayerNameViewController.swift
//  PlaygroundSlot
//
//  Created by TreineticMacbook003 on 8/12/19.
//  Copyright © 2019 TreineticMacbook003. All rights reserved.
//

import UIKit

class PlayerNameViewController: UIViewController, UITextFieldDelegate {

    static let game = Game()
    
    @IBOutlet weak var playerName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerName.delegate = self
        
    }
    
    func textField(_ playerName: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 8
        let currentString: NSString = playerName.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }

    @IBAction func didClickBack(_ sender: Any) {
        performSegue(withIdentifier: "backToHome", sender: nil)
    }
    
    @IBAction func didClickPlay(_ sender: Any) {
        print(playerName.text)
        
        if(playerName.text != ""){
            UserDefaults.standard.set(playerName.text, forKey: "playerName" )
            UserDefaults.standard.synchronize()
            
            
            performSegue(withIdentifier: "goToPlay", sender: nil)
        }else{
            print("Fill Player Name")
        }
        
    }
    
}
