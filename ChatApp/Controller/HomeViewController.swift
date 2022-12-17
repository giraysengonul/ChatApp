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
    private var messageButton: UIBarButtonItem!
    private var newMessageButton: UIBarButtonItem!
    private var container =  Container()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationStatus()
        style()
        layout()
    }
}
// MARK: - Helpers
extension HomeViewController{
    private func configureBarItem(text: String, selector: Selector)-> UIButton{
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
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
        view.backgroundColor = .white
        messageButton = UIBarButtonItem(customView: configureBarItem(text: "Message", selector: #selector(handleMessageButton)))
        newMessageButton = UIBarButtonItem(customView: configureBarItem(text: "New Message", selector: #selector(handleNewMessageButton)))
        self.navigationItem.leftBarButtonItems = [messageButton, newMessageButton]
        //container
        configureContainer()
    }
    private func layout(){
    }
    private func  configureContainer(){
        guard let containerView = container.view else{ return }
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
// MARK: - Selector
extension HomeViewController{
    @objc private func handleMessageButton(){
        
    }
    @objc private func handleNewMessageButton(){
        
    }
}


class Container: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
    }
}
