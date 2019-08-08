//
//  HowToPlayViewController.swift
//  LuckyStrike
//
//  Created by TreineticMacbook003 on 8/2/19.
//  Copyright © 2019 TreineticMacbook003. All rights reserved.
//

import UIKit

class HowToPlayViewController: UIViewController {

    @IBOutlet weak var textAppVersion: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        textAppVersion.text = "V\(self.getVersion())" 
    }
    

    
    @IBAction func didClickBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
extension UIViewController {
    
    func getVersion() -> String{
        
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    func getBuild() -> String{
        
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }
}
