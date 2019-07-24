//
//  Home_VC.swift
//  777 JACKPOT
//
//  Created by Treinetic Macbook 001 on 7/24/19.
//  Copyright © 2019 Treinetic Macbook 001. All rights reserved.
//

import UIKit

class Home_VC: UIViewController {
    
    @IBOutlet weak var resultsView: UIView!
    @IBOutlet weak var victoryView: UIView!
    @IBOutlet weak var goButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.uiConfig()
        // Do any additional setup after loading the view.
    }
    
    func uiConfig(){
        
        self.resultsView.layer.borderWidth = 5
        self.resultsView.layer.borderColor = UIColor.white.cgColor
        
        self.victoryView.layer.borderWidth = 5
        self.victoryView.layer.borderColor = UIColor(named: "Secondary")?.cgColor
        
        self.goButton.layer.borderWidth = 5
        self.goButton.layer.borderColor = UIColor.white.cgColor
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
