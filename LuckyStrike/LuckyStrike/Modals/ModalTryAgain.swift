//
//  ModalTryAgain.swift
//  LuckyStrike
//
//  Created by TreineticMacbook003 on 8/5/19.
//  Copyright © 2019 TreineticMacbook003. All rights reserved.
//

import Foundation
import UIKit
class ModalTryAgain : UIView{
    
    var closeModal : (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initXib()
    }
    
    private func initXib() {
        let nib = UINib.init(nibName: "ModalTryAgain", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    
    @IBAction func didClickClose(_ sender: Any) {
        closeModal!()
    }
    
    
    @IBAction func didClickPlayAgain(_ sender: Any) {
        closeModal!()
    }
}
