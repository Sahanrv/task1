//
//  Second_VC.swift
//  sampleCallback
//
//  Created by Treinetic Macbook 001 on 8/2/19.
//  Copyright © 2019 Treinetic Macbook 001. All rights reserved.
//

import UIKit

class Second_VC: UIViewController {
    
    
    var callBackFunc : (() -> ())?
     // var closeAlert = ((_ name : String) -> String)
    override func viewDidLoad() {
        super.viewDidLoad()
        
      

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickCallBack(_ sender: Any) {
        
    //  if  let callback = callBackFunc {
        callBackFunc!()
      //  }
//        let name = closeAlert!("kamal")
//        print(name)
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


extension Second_VC: didClickOnButtonDelegate {
    func didClick(name: String!) {
        print(name)
    }
    
    
}
