//
//  ViewController.swift
//  RestAPITest
//
//  Created by Hasitha Mapalagama on 7/18/19.
//  Copyright © 2019 Hasitha Mapalagama. All rights reserved.
//

import UIKit
import SwiftyJSON
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let storyBoard = UIStoryboard.init(name: "Second", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "second_vc")
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func didClickButton(_ sender: Any) {
        let endpoint = Endpoint.init(url: "http://dummy.restapiexample.com/api/v1/employees")
        let net = Net.init(url: endpoint, method: TMethod.post, param: [
                "username" : "Hasitha" as AnyObject,
                "password" : "123" as AnyObject
            ])
        net.expected = .data
        net.onError = { error in
           
        }
        net.onCompletion = { data in

            // hide loading
        }
        net.perform()
        
        // show loading
    }
}



class Employee {
    var id : String!
    var employeeName : String!
    var employeeSalary : String!
    
    init() {
        
    }
    
    init(json : JSON) {
        self.id = json["id"].stringValue
        self.employeeName = json["employee_name"].stringValue
        self.employeeSalary = json["employee_salary"].stringValue
    }
    
    
    static func fromArray(json : JSON) -> [Employee] {
        return (json.array ?? []).map { jsonEmp in
            return Employee.init(json: jsonEmp)
        }
    }
    
}


class Page {
    var page : Int!
    var per_page : Int!
    var total : Int!
    var data = [Employee]()
    
    init() {
        
    }
    
    init(json : JSON) {
        self.page = json["page"].intValue
        self.per_page = json["per_page"].intValue
        self.total = json["total"].intValue
        self.data = Employee.fromArray(json: json["data"])
    }
    
}
