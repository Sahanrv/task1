//
//  LoginViewModel.swift
//  TodoAppRx
//
//  Created by Treinetic Macbook 001 on 9/6/19.
//  Copyright © 2019 Treinetic Macbook 001. All rights reserved.
//

import Foundation
import RxSwift

struct LoginViewModel {
    var emailtxt = Variable<String>("")
    var passwordtxt = Variable<String>("")
    
    var isValid: Observable<Bool> {
        return Observable.combineLatest(emailtxt.asObservable(), passwordtxt.asObservable()) { email, password in
            email.count >= 3 && password.count >= 3
        }
    }
}
