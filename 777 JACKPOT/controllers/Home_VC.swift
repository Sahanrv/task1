//
//  Home_VC.swift
//  777 JACKPOT
//
//  Created by Treinetic Macbook 001 on 7/24/19.
//  Copyright © 2019 Treinetic Macbook 001. All rights reserved.
//

import UIKit

class Home_VC: UIViewController {
    
    @IBOutlet weak var pickerView1: UIPickerView!
    @IBOutlet weak var pickerView2: UIPickerView!
    @IBOutlet weak var pickerView3: UIPickerView!
    
    @IBOutlet weak var resultsView: UIView!
    @IBOutlet weak var victoryView: UIView!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    var arra1 = [Int]()
    var arra2 = [Int]()
    var arra3 = [Int]()
    
    let total = 200
    var inserver = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.uiConfig()
        self.hideVictoryView()
        self.setArrayValues()
        self.setValuesToPicker()
        self.setPicherViewConfig()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for i in [1, 2] {
            pickerView1.subviews[i].isHidden = true
        }
    }
    

    
    func setArrayValues(){
        
        let temp = [0, 1,2,3,4,5,6,7,8,9]
        //let temp = [7,7,7,7,7,7,7,7,7,7]
        self.arra1 = temp.shuffled()
        self.arra2 = temp.shuffled()
        self.arra3 = temp.shuffled()
    }
    
    func setValuesToPicker(){
        
    }
    
    func setPicherViewConfig(){
        
        self.pickerView1.delegate = self
        self.pickerView1.dataSource = self
        
        self.pickerView2.delegate = self
        self.pickerView2.dataSource = self
        
        self.pickerView3.delegate = self
        self.pickerView3.dataSource = self
        
    }
    
    func uiConfig(){
        
        self.resultsView.layer.borderWidth = 5
        self.resultsView.layer.borderColor = UIColor.white.cgColor
        
        self.victoryView.layer.borderWidth = 5
        self.victoryView.layer.borderColor = UIColor(named: "Secondary")?.cgColor
        
        self.goButton.layer.borderWidth = 5
        self.goButton.layer.borderColor = UIColor.white.cgColor
    }
    
    func hideVictoryView(){
        self.victoryView.isHidden = true
    }
    
    func viewVictoryView(status: String!){
        self.victoryView.isHidden = false
        self.statusLabel.text = status
    }
    
    func randomNumber(num: Int)-> Int{
        return Int(arc4random_uniform(UInt32(num)))
    }
    
    func goButtonAnimation(){
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //Go button +
            self.goButton.bounds.size.width += 10
        }, completion: {finished in
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                //Go button -
                self.goButton.bounds.size.width -= 10
            }, completion: nil)
        })
        
    }
    
    @IBAction func GO(_ sender: Any) {
        
        self.hideVictoryView()
        self.goButtonAnimation()

        self.pickerView1.selectRow((randomNumber(num: 10)), inComponent: 0, animated: true)
        self.pickerView2.selectRow((randomNumber(num: 10)), inComponent: 0, animated: true)
        self.pickerView3.selectRow((randomNumber(num: 10)), inComponent: 0, animated: true)
        
        print("Picker View1 Value is = ",arra1[pickerView1.selectedRow(inComponent: 0)])
        print("Picker View2 Value is = ",arra2[pickerView2.selectedRow(inComponent: 0)])
        print("Picker View3 Value is = ",arra3[pickerView3.selectedRow(inComponent: 0)])
        
        if arra1[pickerView1.selectedRow(inComponent: 0)] == arra2[pickerView2.selectedRow(inComponent: 0)] &&
            arra2[pickerView2.selectedRow(inComponent: 0)] == arra3[pickerView3.selectedRow(inComponent: 0)] {
            
            print("Win ")
            self.viewVictoryView(status: "Victory")
        }
         
        
       
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension Home_VC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.total
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if pickerView == pickerView1 {
            return self.arra1.count
        }else if pickerView == pickerView2 {
            return self.arra1.count
        }
        
        return self.arra1.count

    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 80
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 80
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label1 = UILabel()
        let label2 = UILabel()
        let label3 = UILabel()
        
        
        label1.textAlignment = .center
        label2.textAlignment = .center
        label3.textAlignment = .center

        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor : UIColor.black,
            NSAttributedString.Key.strokeWidth : -2.0,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 44)
            ] as [NSAttributedString.Key : Any]
        
        label1.attributedText = NSAttributedString(string: String(self.arra1[row]), attributes: strokeTextAttributes)
        label2.attributedText = NSAttributedString(string: String(self.arra2[row]), attributes: strokeTextAttributes)
        label3.attributedText = NSAttributedString(string: String(self.arra3[row]), attributes: strokeTextAttributes)

        // label1.text = String(self.arra1[row])
//         label2.text = String(self.arra2[row])
//         label3.text = String(self.arra3[row])
//        
        if pickerView == self.pickerView1{
              return label1
        }else if pickerView == self.pickerView2{
             return label2
        }

        return label3

       
    }

   
}
