//
//  AuthenticationService.swift
//  ChatApp
//
//  Created by hakkı can şengönül on 16.12.2022.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

struct AuthenticationServiceUser {
    var emailText: String
    var passwordText: String
    var nameText: String
    var usernameText: String
}

struct AuthenticationService {
    
    static func register(withUser user: AuthenticationServiceUser,image: UIImage, completion: @escaping(Error?)->Void){
        let photoName = UUID().uuidString
        guard let profileData = image.jpegData(compressionQuality: 0.5) else{ return }
        let referance = Storage.storage().reference(withPath: "media/profile_image/\(photoName).png")
        referance.putData(profileData) { storageMeta, error in
            if let error = error {
                completion(error)
                return
            }
            referance.downloadURL { url, error in
                if let error = error {
                    completion(error)
                    return
                }
                guard let profileImageUrl = url?.absoluteString else{ return }
                Auth.auth().createUser(withEmail: user.emailText, password: user.passwordText) { result, error in
                    if let error = error{
                        completion(error)
                        return
                    }
                    guard let userUid = result?.user.uid else{ return }
                    let data = [
                        "email": user.emailText,
                        "name": user.nameText,
                        "username": user.usernameText,
                        "profileImageUrl": profileImageUrl,
                        "uid": userUid
                    ] as [String: Any]
                    Firestore.firestore().collection("users").document(userUid).setData(data,completion: completion)
                }
            }
        }
    }
}
