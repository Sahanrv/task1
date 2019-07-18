//
//  todoViewCell.swift
//  treineticApp
//
//  Created by Treinetic Macbook 001 on 7/17/19.
//  Copyright © 2019 Treinetic Macbook 001. All rights reserved.
//

import UIKit

protocol CheckRowDelegate {
    func didTapCheckBox(checked: Bool, index :Int)
}

class todoViewCell: UITableViewCell {
   
    var index: Int!
    var rowCheckDelegate: CheckRowDelegate!
    
    @IBOutlet weak var todoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.profileImg.layer.cornerRadius = self.profileImg.bounds.height / 2
//        profileImg.clipsToBounds = true
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func checkButtonAction(_ sender: Any) {
        
        print("Checked Button")
        rowCheckDelegate.didTapCheckBox(checked: true, index: index)
    }
    
    
}
