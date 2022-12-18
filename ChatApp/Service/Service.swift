//
//  Service.swift
//  ChatApp
//
//  Created by hakkı can şengönül on 18.12.2022.
//

import Foundation
import FirebaseFirestore

struct Service {
    static func fetchUsers(completion: @escaping([User])-> Void){
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            if let error = error{
                print("Error: \(error.localizedDescription)")
            }
            users = snapshot?.documents.map({ User(data: $0.data())}) ?? []
            completion(users)
        }
    }
}
