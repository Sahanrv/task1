//
//  ViewController.swift
//  treineticApp
//
//  Created by Treinetic Macbook 001 on 7/17/19.
//  Copyright © 2019 Treinetic Macbook 001. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {


    @IBOutlet weak var toDoTableView: UITableView!
    
    var data:[String] = []
    var doneData: [String] = []
    var selectedRow:Int = -1
    
    let defaults = UserDefaults.standard
    let doneDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(data)
       
        let newTodo = defaults.stringArray(forKey: "toDoKey") ?? [String]()
        self.data = newTodo
        
        toDoTableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addToDo(_ sender: Any) {
        if toDoTableView.isEditing {
            return
        }
        let noteName:String = ""
        data.insert(noteName, at: 0)
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        toDoTableView.insertRows(at: [indexPath], with: .automatic)
        toDoTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        self.performSegue(withIdentifier: "addtodo", sender: nil)
    }
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
         let cell = tableView.dequeueReusableCell(withIdentifier: "todoViewCell", for: indexPath) as! todoViewCell
        cell.todoLabel.text = data[indexPath.row]
        cell.index = indexPath.item
        cell.rowCheckDelegate = self
        cell.checkBox.isSelected = false
        
//
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        
        
        
    }
    
    


}

extension ViewController: CheckRowDelegate {
    func didTapCheckBox(checked: Bool, index: Int) {
        if checked == true {
            print("Index Is : \(index)")
            
            let doneTask = self.data[index]
            self.doneData.append(doneTask)
            doneDefault.set(doneData, forKey: "doneKey")
            doneDefault.synchronize()
            
            self.data.remove(at: index)
            self.defaults.set(data, forKey: "toDoKey")
            toDoTableView.reloadData()
        }
    }
    
    
}

