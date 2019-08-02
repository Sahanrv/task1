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
//    var text : String?
    
let customeView = CustomAlert()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func didClickShowAlert(_ sender: Any) {
        
//        customeView.getData = { name -> String in
//            print("Invoke with ", name)
//            return "Hello \(name), \(self.text)"
        
//        }
        
        
//        self.customAlertView.getDta(handle : {v in
//            if v {SwiftEntryKit.dismiss()}
//        })
        
        
        customeView.closeAlert = { v in

            print(v)
            SwiftEntryKit.dismiss()

            return "kasun"
        }
        
//        customeView.closeAlert = {
//
//                        print("Called")
//
//        }
        
        
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
    
    
    
    @IBAction func didClickAlertNew(_ sender: Any) {
       
         let alert = AlertNew()
        var attributes = EKAttributes()
        attributes.displayDuration = .infinity
        attributes.position = .center
        attributes.entranceAnimation = .init(translate: .none,
                                             scale: .init(from: 0, to: 1, duration: 0.4),
                                             fade: .init(from: 0, to: 1, duration: 0.2))
        attributes.entryInteraction = .absorbTouches
         attributes.precedence.priority = .high
        attributes.entryBackground = .clear
        attributes.screenBackground = .clear
        //attributes.entryBackground = .color(color: .standardContent)
        //attributes.screenBackground = .color(color: EKColor(UIColor(white: 0.5, alpha: 0.5)))
        attributes.roundCorners = .top(radius: 30)
        attributes.border = .value(color: .red, width: 0.5)
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        SwiftEntryKit.display(entry: alert, using: attributes)
        
    }
    
}

//extension ViewController : CustomAlertDelegate {
//    func didClickDismiss() {
//        SwiftEntryKit.dismiss()
//    }
//
//}

