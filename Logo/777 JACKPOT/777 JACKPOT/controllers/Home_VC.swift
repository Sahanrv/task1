//
//  Home_VC.swift
//  777 JACKPOT
//
//  Created by Treinetic Macbook 001 on 7/24/19.
//  Copyright © 2019 Treinetic Macbook 001. All rights reserved.
//

import UIKit

class Home_VC: UIViewController {
    
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var collectionView3: UICollectionView!
    
    @IBOutlet weak var resultsView: UIView!
    @IBOutlet weak var victoryView: UIView!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var number1: UILabel!
    @IBOutlet weak var number2: UILabel!
    @IBOutlet weak var number3: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var arra1 = [Int]()
    var arra2 = [Int]()
    var arra3 = [Int]()
    
    let total = 200
    var inserver = 1
//   let collectionView =  UICollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.uiConfig()
        self.hideVictoryView()
        self.collectionVIewConfig()
        self.setArrayValues()
        // Do any additional setup after loading the view.
    }
    
    func setArrayValues(){
        
        let temp = [0, 1,2,3,4,5,6,7,8,9]
        self.arra1 = temp.shuffled()
        self.arra2 = temp.shuffled()
        self.arra3 = temp.shuffled()
    }
    
    func collectionVIewConfig(){
        
        self.collectionView1.delegate = self
        self.collectionView1.dataSource = self
        
        self.collectionView2.delegate = self
        self.collectionView2.dataSource = self

        self.collectionView3.delegate = self
        self.collectionView3.dataSource = self
        
        self.collectionView3.scrollToItem(at: IndexPath.init(row: total / 2 , section: 0), at: .centeredVertically, animated: false)
        self.collectionView2.scrollToItem(at: IndexPath.init(row: total / 2 , section: 0), at: .centeredVertically, animated: false)
        self.collectionView1.scrollToItem(at: IndexPath.init(row: total / 2 , section: 0), at: .centeredVertically, animated: false)
        
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
    
    @IBAction func GO(_ sender: Any) {
        
        self.hideVictoryView()
        
        let rands = [
            (total / 2) + (Int.random(in: 30...33) * self.inserver),
            (total / 2) + (Int.random(in: 30...33) * (self.inserver * -1)),
            (total / 2) + (Int.random(in: 30...33) * self.inserver)
        ]
        
        self.collectionView1.scrollToItem(at: IndexPath.init(item:  rands[0], section: 0), at: .centeredVertically, animated: true)
        self.collectionView2.scrollToItem(at: IndexPath.init(item:  rands[1], section: 0), at: .centeredVertically, animated: true)
        self.collectionView3.scrollToItem(at: IndexPath.init(item:  rands[2], section: 0), at: .centeredVertically, animated: true)
        
        print("value \(arra1[rands[0] % arra1.count]) ")
        print("value \(arra2[rands[1] % arra1.count]) ")
        print("value \(arra3[rands[2] % arra1.count]) ")
        
        if (arra1[rands[0] % arra1.count] == arra2[rands[1] % arra1.count]
            &&
            arra2[rands[1] % arra1.count] == arra3[rands[2] % arra1.count])
           {
            
            self.viewVictoryView(status: "Victory")
            
        }else{
            self.viewVictoryView(status: "Unlucky")
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

extension Home_VC: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.total
        
        //return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let idx = indexPath.item % self.arra1.count
        
        if collectionView == collectionView1{
            let cell: CollectionViewCell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell1", for: indexPath) as! CollectionViewCell1
            
            let val1 = arra1[idx]
            cell.label1.text = String(val1)
            
            return cell
            
        } else if collectionView == collectionView2{
            let cell2: CollectionViewCell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell2", for: indexPath) as! CollectionViewCell2
            
            let val1 = arra2[idx]
            cell2.label2.text = String(val1)
            
            return cell2
        
        }else {
            let cell3: CollectionViewCell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell3", for: indexPath) as! CollectionViewCell3
            
            let val1 = arra3[idx]
            cell3.label3.text = String(val1)
            
            return cell3
        }
        
       
    }
    
    
}
