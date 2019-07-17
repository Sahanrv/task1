//
//  AddToDoViewController.swift
//  treineticApp
//
//  Created by Treinetic Macbook 001 on 7/17/19.
//  Copyright © 2019 Treinetic Macbook 001. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController {

    @IBOutlet weak var todoTextView: UITextView!
    @IBOutlet weak var addToDo: UIButton!
    
    var text: String = ""
    
    
    let defaults = UserDefaults.standard
    var todo: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTextView.text = text
        
        todo = defaults.stringArray(forKey: "toDoKey") ?? [String]()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addToDo(_ sender: Any) {
        let newToDo = self.todoTextView.text!
        self.todo.append(newToDo)
        defaults.set(self.todo, forKey: "toDoKey")
        defaults.synchronize()
        
        self.dismiss(animated: true, completion: nil)
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
