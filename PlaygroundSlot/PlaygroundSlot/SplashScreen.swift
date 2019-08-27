//
//  ViewController.swift
//  PlaygroundSlot
//
//  Created by TreineticMacbook003 on 8/9/19.
//  Copyright © 2019 TreineticMacbook003. All rights reserved.
//

import UIKit

class SplashScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            self.performSegue(withIdentifier: "splashToHome", sender: nil)
        })
        
    }


}

