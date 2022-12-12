//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by hakkı can şengönül on 12.12.2022.
//

import Foundation

struct LoginViewModel {
    var emailTextField: String?
    var passwordTextField: String?
    var status:Bool {
        return emailTextField?.isEmpty == false && passwordTextField?.isEmpty == false
    }
    
}
