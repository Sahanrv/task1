//
//  ViewController.swift
//  sampleCallback
//
//  Created by Treinetic Macbook 001 on 8/1/19.
//  Copyright © 2019 Treinetic Macbook 001. All rights reserved.
//

import UIKit

protocol didClickOnButtonDelegate {
    func didClick(name: String!)
}

class ViewController: UIViewController {
    
    //var sampleData = SampleData()
    
    let newCall = Second_VC()
    var btnCheckDelegate: didClickOnButtonDelegate!
    var name : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        sampleData.getData(handler: { v in
//           sampleLabel.text = String(v)
//        })
        
        self.name = "Sakun"
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "second" {
            let vc = segue.destination as! Second_VC
            vc.callBackFunc = {
                
                print("Callrd")
            }
        }
    }
    
    @IBAction func secondVcCLick(_ sender: Any) {
        
        btnCheckDelegate.didClick(name: self.name)
        
        
        
        
//        customeView.closeAlert = { v in
//
//            print(v)
//            //SwiftEntryKit.dismiss()
//
//            return "kasun"
//        }
        
    }
    

    @IBOutlet weak var sampleLabel: UILabel!
    
}

