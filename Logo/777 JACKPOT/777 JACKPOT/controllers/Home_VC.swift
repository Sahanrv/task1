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
        }
    }
    
    func collectionVIewConfig(){
        
        self.collectionView1.delegate = self
        self.collectionView1.dataSource = self
        
//        self.collectionView2.delegate = self
//        self.collectionView2.dataSource = self
//
//        self.collectionView3.delegate = self
//        self.collectionView3.dataSource = self
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
        return arra1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell1", for: indexPath) as! CollectionViewCell1
        
        let val1 = arra1[indexPath.row]
        cell.label1.text = String(val1)
        
        return cell
    }
    
    
}