//
//  doneViewCell.swift
//  treineticApp
//
//  Created by Treinetic Macbook 001 on 7/18/19.
//  Copyright © 2019 Treinetic Macbook 001. All rights reserved.
//

import UIKit
import UICheckbox_Swift

protocol checkedToDoDelegate {
    func didTapCheckBox(checked: Bool, index :Int)
}

class doneViewCell: UITableViewCell {

    @IBOutlet weak var donTasksLabel: UILabel!
    
    var index: Int!
    var rowCheckDelegate: checkedToDoDelegate!
    
    @IBOutlet weak var checkBox: UICheckbox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func checkedAdd(_ sender: Any) {
        rowCheckDelegate.didTapCheckBox(checked: true, index: index)
    }
    
}
