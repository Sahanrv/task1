//
//  Done.swift
//  treineticApp
//
//  Created by Treinetic Macbook 001 on 7/17/19.
//  Copyright © 2019 Treinetic Macbook 001. All rights reserved.
//

import UIKit

class DoneController: UIViewController {

    @IBOutlet weak var tabelView: UITableView!
    var doneList: [String] = []
    let doneData = UserDefaults.standard
    
    var todoList: [String] = []
    let todoData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        doneList = doneData.stringArray(forKey: "doneKey") ?? [String]()
        
        tabelView.delegate = self
        tabelView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
       
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

extension DoneController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.doneList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: doneViewCell = tabelView.dequeueReusableCell(withIdentifier: "doneViewCell", for: indexPath) as! doneViewCell
        
        cell.donTasksLabel.text = doneList[indexPath.row]
        
        cell.index = indexPath.item
        cell.rowCheckDelegate = self as? checkedToDoDelegate
        cell.checkBox.isSelected = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
        
        
    }
    
    
}

extension DoneController: checkedToDoDelegate {
    func didTapCheckBox(checked: Bool, index: Int) {
        //Get record for todo
        let todo = doneList[index]
        self.todoList = todoData.stringArray(forKey: "toDoKey") ?? [String]()
        todoList.append(todo)
        todoData.set(todoList, forKey: "toDoKey")
        
        //Remove record from done
        doneList.remove(at: index)
        todoData.set(doneList, forKey: "doneKey")
        todoData.synchronize()
        
        tabelView.reloadData()
    }
    
    
}



