//
//  ViewController.swift
//  Spin It
//
//  Created by Treinetic Macbook 001 on 7/29/19.
//  Copyright © 2019 Treinetic Macbook 001. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var secondaryView: UIView!
    @IBOutlet weak var pickerView1: UIPickerView!
    @IBOutlet weak var pickerView2: UIPickerView!
    @IBOutlet weak var pickerView3: UIPickerView!
    @IBOutlet weak var pickerView4: UIPickerView!
    
    @IBOutlet weak var dialog: UIImageView!
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var sinButton: UIButton!
    
    @IBOutlet weak var countLabel: UILabel!
    
    var imageArray1 = [String]()
    var imageArray2 = [String]()
    var imageArray3 = [String]()
    var imageArray4 = [String]()
    
    let total = 200
    var inserver = 3
    var buttonCount = 0 {
        didSet{
            self.viewDialog()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideDialog()
        self.UiConfig()
        self.setArrayValues()
        self.setPicherViewConfig()
        // Do any additional setup after loading the view.
    }
    
  
    func UiConfig(){
        self.secondaryView.layer.borderColor = UIColor(named: "secondary")?.cgColor
        self.secondaryView.layer.borderWidth = 5
        
        self.secondaryView.clipsToBounds = true
        self.secondaryView.layer.cornerRadius = 10
        self.secondaryView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        
        self.pickerView1.layer.borderWidth = 2
        self.pickerView1.layer.borderColor = UIColor(named: "secondary")?.cgColor
        self.pickerView2.layer.borderWidth = 2
        self.pickerView2.layer.borderColor = UIColor(named: "secondary")?.cgColor
        self.pickerView3.layer.borderWidth = 2
        self.pickerView3.layer.borderColor = UIColor(named: "secondary")?.cgColor
        self.pickerView4.layer.borderWidth = 2
        self.pickerView4.layer.borderColor = UIColor(named: "secondary")?.cgColor
        
        self.countLabel.text = "YOU HAVE \(self.inserver) CHANCES"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for i in [1, 2] {
            pickerView1.subviews[i].isHidden = true
            pickerView2.subviews[i].isHidden = true
            pickerView3.subviews[i].isHidden = true
            pickerView4.subviews[i].isHidden = true
        }
    }
    
    func setArrayValues(){
        
        let temp = ["banana", "cherry","mango","orange"]
        //let temp = ["banana", "banana","banana","banana"]
        self.imageArray1 = temp.shuffled()
        self.imageArray2 = temp.shuffled()
        self.imageArray3 = temp.shuffled()
        self.imageArray4 = temp.shuffled()
    }
    
    func setPicherViewConfig(){
        
        self.pickerView1.delegate = self
        self.pickerView1.dataSource = self
        
        self.pickerView2.delegate = self
        self.pickerView2.dataSource = self
        
        self.pickerView3.delegate = self
        self.pickerView3.dataSource = self
        
        self.pickerView4.delegate = self
        self.pickerView4.dataSource = self
        
    }
    
    func viewDialog(){
        self.dialogView.isHidden = false
    }
    
    func hideDialog(){
        self.dialogView.isHidden = true
    }
    
    func randomNumber(num: Int)-> Int{
        return Int(arc4random_uniform(UInt32(num)))
    }

    @IBAction func spinButtonClick(_ sender: Any) {
        
        self.sinButton.isEnabled = false
        
        self.countLabel.text = "YOU HAVE \(self.inserver) CHANCES"
        
        if(self.inserver == 0){

            self.buttonCount = 1
            

        }
        
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fire), userInfo: nil, repeats: false)
        
        
    
        
        self.pickerView1.selectRow((randomNumber(num: 10)), inComponent: 0, animated: true)
        self.pickerView2.selectRow((randomNumber(num: 10)), inComponent: 0, animated: true)
        self.pickerView3.selectRow((randomNumber(num: 10)), inComponent: 0, animated: true)
        self.pickerView4.selectRow((randomNumber(num: 10)), inComponent: 0, animated: true)
        
        print("Picker View1 Value is = ",imageArray1[pickerView1.selectedRow(inComponent: 0)])
        print("Picker View2 Value is = ",imageArray2[pickerView2.selectedRow(inComponent: 0)])
        print("Picker View3 Value is = ",imageArray3[pickerView3.selectedRow(inComponent: 0)])
        print("Picker View4 Value is = ",imageArray4[pickerView4.selectedRow(inComponent: 0)])
        
        if imageArray1[pickerView1.selectedRow(inComponent: 0)] == imageArray2[pickerView2.selectedRow(inComponent: 0)] &&
            imageArray2[pickerView2.selectedRow(inComponent: 0)] == imageArray3[pickerView3.selectedRow(inComponent: 0)] && imageArray3[pickerView3.selectedRow(inComponent: 0)] == imageArray4[pickerView4.selectedRow(inComponent: 0)] {
            
            self.dialog.image = UIImage(named: "win")
            print("Win")
            //self.viewDialog()
            
        }else{
            self.dialog.image = UIImage(named: "try")
            print("Try")
            self.inserver = self.inserver - 1

            
        }
        
        print(self.inserver)
      
        
        
    }
    
    @objc func fire(){
        self.sinButton.isEnabled = true
    }
    
    @IBAction func dialogViewClick(_ sender: Any) {
        self.inserver = 3
         self.countLabel.text = "YOU HAVE \(self.inserver) CHANCES"
        self.hideDialog()
    }
    
    


}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.total
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == pickerView1 {
            return self.imageArray1.count
        }else if pickerView == pickerView2 {
            return self.imageArray2.count
        }else if pickerView == pickerView3{
            return self.imageArray3.count
        }
        
        return self.imageArray4.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 80
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let image1 = UIImageView()
        let image2 = UIImageView()
        let image3 = UIImageView()
        let image4 = UIImageView()
        
        image1.image = UIImage(named: String(self.imageArray1[row]))
        image2.image = UIImage(named: String(self.imageArray2[row]))
        image3.image = UIImage(named: String(self.imageArray3[row]))
        image4.image = UIImage(named: String(self.imageArray4[row]))

        if pickerView == self.pickerView1{
            return image1
        }else if pickerView == self.pickerView2{
            return image2
        }else if pickerView == self.pickerView3{
            return image3
        }
        
        return image4
        
        
    }
}

