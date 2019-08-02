//
//  MyDialog.swift
//  EntryKitTest
//
//  Created by Treinetic Macbook 002 on 8/2/19.
//  Copyright © 2019 Treinetic Mackbook 005. All rights reserved.
//

import Foundation
import UIKit

class MyDialog : UIView{
    
    var closeAlert : (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initXib()
    }
    
    private func initXib() {
        let nib = UINib.init(nibName: "MyDialog", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    @IBAction func didClose(_ sender: Any) {
        closeAlert!()
    }
}
