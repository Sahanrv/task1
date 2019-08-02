//
//  CustomAlert.swift
//  EntryKitTest
//
//  Created by Treinetic Mackbook 005 on 8/1/19.
//  Copyright © 2019 Treinetic Mackbook 005. All rights reserved.
//

import Foundation
import UIKit
protocol CustomAlertDelegate {
    func didClickDismiss()
}

class CustomAlert : UIView{
    
    @IBOutlet weak var alertButton: UIButton!
    
    var getData : ((_ name : String) -> String)? 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initXib()
    }
    
    private func initXib() {
        let nib = UINib.init(nibName: "CustomAlert", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    @IBAction func alertButtonClick(_ sender: Any) {
        let out = self.getData?("Hasitha")
        print(out)
    }
}
