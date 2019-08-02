//
//  ViewController.swift
//  EntryKitTest
//
//  Created by Treinetic Mackbook 005 on 8/1/19.
//  Copyright © 2019 Treinetic Mackbook 005. All rights reserved.
//

import UIKit
import SwiftEntryKit

class ViewController: UIViewController {

    var customAlertView = CustomAlert()
    var text : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func didClickShowAlert(_ sender: Any) {
        let customeView = CustomAlert()
        customeView.getData = { name -> String in
            print("Invoke with ", name)
            return "Hello \(name), \(self.text)"
        }
        
        
        var attributes = EKAttributes()
        attributes.displayDuration = .infinity
        attributes.position = .center
        attributes.entranceAnimation = .init(translate: .none,
                                             scale: .init(from: 0, to: 1, duration: 0.4),
                                             fade: .init(from: 0, to: 1, duration: 0.2))
        attributes.entryInteraction = .absorbTouches
        SwiftEntryKit.display(entry: customeView, using: attributes)
        
       

    }

    func close() -> Bool {
        SwiftEntryKit.dismiss()
        return true
    }
}

extension ViewController : CustomAlertDelegate {
    func didClickDismiss() {
        SwiftEntryKit.dismiss()
    }

}

