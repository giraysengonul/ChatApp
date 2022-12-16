//
//  HomeViewController.swift
//  ChatApp
//
//  Created by hakkı can şengönül on 16.12.2022.
//

import UIKit
import FirebaseAuth
class HomeViewController: UIViewController {
     // MARK: - Properties
     // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        signOut()
        style()
        layout()
    }
}
 // MARK: - Helpers
extension HomeViewController{
    private func authenticationStatus(){
        if Auth.auth().currentUser?.uid == nil{
            DispatchQueue.main.async {
                let controller = UINavigationController(rootViewController: LoginViewController())
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true)
            }
        }
    }
    private func signOut(){
        do{
            try Auth.auth().signOut()
            authenticationStatus()
        }catch{
            
        }
    }
    private func style(){
        view.backgroundColor = .red
    }
    private func layout(){
    }
}
