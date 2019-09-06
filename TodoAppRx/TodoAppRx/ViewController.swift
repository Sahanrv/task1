//
//  ViewController.swift
//  TodoAppRx
//
//  Created by Treinetic Macbook 001 on 9/6/19.
//  Copyright © 2019 Treinetic Macbook 001. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var enailtxt: UITextField!
    @IBOutlet weak var passwordtxt: UITextField!
    @IBOutlet weak var loginbtn: UIButton!
    @IBOutlet weak var loginStatuslb: UILabel!
    
    var loginViewModel = LoginViewModel()
    let dispossBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uiConfig()
        // Do any additional setup after loading the view.
    }
    
    func uiConfig(){
        _ = enailtxt.rx.text.map {$0 ?? ""}.bind(to: loginViewModel.emailtxt)
        _ = passwordtxt.rx.text.map{$0 ?? ""}.bind(to: loginViewModel.passwordtxt)
        
        _ = loginViewModel.isValid.bind(to: loginbtn.rx.isEnabled)
        
        loginViewModel.isValid.subscribe(onNext: {isValid in
            self.loginStatuslb.text = isValid ? "Enabled" : "Not Enable"
            self.loginStatuslb.textColor = isValid ? UIColor.green : UIColor.red
            print(isValid)
            
        }).disposed(by: dispossBag)
    }


}

