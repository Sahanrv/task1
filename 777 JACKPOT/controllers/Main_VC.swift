//
//  ViewController.swift
//  777 JACKPOT
//
//  Created by Treinetic Macbook 001 on 7/24/19.
//  Copyright © 2019 Treinetic Macbook 001. All rights reserved.
//

import UIKit

class Main_VC: UIViewController {


    @IBOutlet weak var label777: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.uiConfig()
        self.viewHome()
        
       
        // Do any additional setup after loading the view.
    }
    
    func uiConfig(){
        
//        let strokeTextAttributes = [
//            NSAttributedString.Key.strokeColor : UIColor(named: "Secondary")!.cgColor,
//            NSAttributedString.Key.foregroundColor : UIColor.white,
//            NSAttributedString.Key.strokeWidth : -4.0,
//            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)]
//            as [NSAttributedString.Key : Any]
//
//
//        self.label777.attributedText = NSMutableAttributedString(string: "777", attributes: strokeTextAttributes)
////        self.label777.attributedText.
    }
    
    func viewHome(){
        DispatchQueue.main.asyncAfter(deadline: .now() , execute: {
            self.performSegue(withIdentifier: "viewHome", sender: nil)
        })
    }
    
   


}

