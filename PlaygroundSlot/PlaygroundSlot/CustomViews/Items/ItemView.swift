//
//  ItemView.swift
//  PlaygroundSlot
//
//  Created by TreineticMacbook003 on 8/12/19.
//  Copyright © 2019 TreineticMacbook003. All rights reserved.
//

import Foundation
import UIKit
class ItemView : UIView{
    
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemPoints: UILabel!
    
    var selectItem : (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initXib()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initXib()
    }
    
    private func initXib() {
        let nib = UINib.init(nibName: "ItemView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    @IBAction func didClickSelectItem(_ sender: Any) {
        selectItem!()
    }
}
