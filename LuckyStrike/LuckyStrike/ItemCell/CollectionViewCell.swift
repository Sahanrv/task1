//
//  CollectionViewCell.swift
//  LuckyStrike
//
//  Created by TreineticMacbook003 on 8/2/19.
//  Copyright © 2019 TreineticMacbook003. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(text : String){
        self.cellLabel.text = text
    }

}
