//
//  ProfileView.swift
//  ChatApp
//
//  Created by hakkı can şengönül on 24.12.2022.
//

import UIKit
import FirebaseAuth
class ProfileView: UIView {
     // MARK: - Properties
     // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 // MARK: - Helpers
extension ProfileView{
    private func style(){
        backgroundColor = .cyan
    }
    private func layout(){
        
    }
    private func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Service.fetchUser(uid: uid) { user in
            print(user.username)
        }
    }
}
