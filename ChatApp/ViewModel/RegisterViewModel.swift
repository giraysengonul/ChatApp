//
//  RegisterViewModel.swift
//  ChatApp
//
//  Created by hakkı can şengönül on 12.12.2022.
//

import Foundation

struct RegisterViewModel {
    var email: String?
    var name: String?
    var userName: String?
    var password: String?
    
    var status: Bool{
        return email?.isEmpty == false && password?.isEmpty == false && userName?.isEmpty == false && name?.isEmpty == false
    }
}
