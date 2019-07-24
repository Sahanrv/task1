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
    
    var arra1 = [Int]()
    var arra2 = [Int]()
    var arra3 = [Int]()
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
        
        for _ in 0...9 {
            let random1 = Int.random(in: 0..<9)
            self.arra1.append(random1)
            let random2 = Int.random(in: 0..<9)
            self.arra2.append(random2)
            let random3 = Int.random(in: 0..<9)
            self.arra3.append(random3)
        }
    }
    
    func collectionVIewConfig(){
        
        self.collectionView1.delegate = self
        self.collectionView1.dataSource = self
        
        self.collectionView2.delegate = self
        self.collectionView2.dataSource = self

        self.collectionView3.delegate = self
        self.collectionView3.dataSource = self
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
    
    @IBAction func GO(_ sender: Any) {
        
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
        
        if collectionView == collectionView1 {
            return arra1.count
        }else if collectionView == collectionView2 {
            return arra2.count
        }
        
        return arra3.count
        
        //return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionView1{
            let cell: CollectionViewCell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell1", for: indexPath) as! CollectionViewCell1
            
            let val1 = arra1[indexPath.row]
            cell.label1.text = String(val1)
            
            return cell
            
        } else if collectionView == collectionView2{
            let cell2: CollectionViewCell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell2", for: indexPath) as! CollectionViewCell2
            
            let val1 = arra2[indexPath.row]
            cell2.label2.text = String(val1)
            
            return cell2
        
        }else {
            let cell3: CollectionViewCell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell3", for: indexPath) as! CollectionViewCell3
            
            let val1 = arra3[indexPath.row]
            cell3.label3.text = String(val1)
            
            return cell3
        }
        
       
    }
    
    
}
