//
//  AlertNew.swift
//  EntryKitTest
//
//  Created by Treinetic Macbook 001 on 8/2/19.
//  Copyright © 2019 Treinetic Mackbook 005. All rights reserved.
//

import Foundation
import UIKit

class AlertNew: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initXib()
    }
    
    private func initXib() {
        let nib = UINib.init(nibName: "AlertNew", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    
    
}
