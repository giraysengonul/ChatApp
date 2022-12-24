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
    private let newMessageViewController = NewMessageViewController()
    private let messageViewController = MessageViewController()
    private lazy var viewControllers:[UIViewController] = [messageViewController, newMessageViewController]
    private let profileView = ProfileView()
    private var isProfileViewActive: Bool = false
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationStatus()
        style()
        layout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleMessageButton()
    }
}
// MARK: - Helpers
extension HomeViewController{
    private func configureBarItem(text: String, selector: Selector)-> UIButton{
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
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
        self.navigationController?.navigationBar.tintColor = .white
        messageButton = UIBarButtonItem(customView: configureBarItem(text: "Message", selector: #selector(handleMessageButton)))
        newMessageButton = UIBarButtonItem(customView: configureBarItem(text: "New Message", selector: #selector(handleNewMessageButton)))
        self.navigationItem.leftBarButtonItems = [messageButton, newMessageButton]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: #selector(handleProfileButton))
        self.newMessageViewController.delegate = self
        self.messageViewController.delegate = self
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.layer.cornerRadius = 20
        profileView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        //container
        configureContainer()
        handleMessageButton()
    }
    private func layout(){
        view.addSubview(profileView)
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            profileView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.6)
        ])
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
    private func showChat(user: User){
        let controller = ChatViewController(user: user)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
// MARK: - Selector
extension HomeViewController{
    @objc private func handleProfileButton(_ sender: UIBarButtonItem){
        UIView.animate(withDuration: 0.5) {
            if self.isProfileViewActive{
                self.profileView.frame.origin.x = self.view.frame.width
            }else{
                self.profileView.frame.origin.x = self.view.frame.width * 0.4
            }
        }
        self.isProfileViewActive.toggle()
        
    }
    @objc private func handleMessageButton(){
        if self.container.children.first == MessageViewController() { return }
        self.container.add(viewControllers[0])
        self.viewControllers[0].view.alpha = 0
        UIView.animate(withDuration: 1) {
            self.messageButton.customView?.alpha = 1
            self.newMessageButton.customView?.alpha = 0.5
            self.viewControllers[0].view.alpha = 1
            self.viewControllers[1].view.frame.origin.x = -1000
        } completion: { _ in
            self.viewControllers[1].remove()
            self.viewControllers[1].view.frame.origin.x = 0
        }
        
        
    }
    @objc private func handleNewMessageButton(){
        if self.container.children.first == NewMessageViewController() { return }
        self.container.add(viewControllers[1])
        self.viewControllers[1].view.alpha = 0
        UIView.animate(withDuration: 1) {
            self.messageButton.customView?.alpha = 0.5
            self.newMessageButton.customView?.alpha = 1
            self.viewControllers[1].view.alpha = 1
            self.viewControllers[0].view.frame.origin.x = +1000
        } completion: { _ in
            self.viewControllers[0].remove()
            self.viewControllers[0].view.frame.origin.x = 0
        }
    }
}
 // MARK: - NewMessageViewControllerProtocol
extension HomeViewController: NewMessageViewControllerProtocol{
    func goToChatView(user: User) {
        self.showChat(user: user)
    }
}
 // MARK: - MessageViewControllerProtocol
extension HomeViewController: MessageViewControllerProtocol{
    func showChatViewController(_ messageViewController: MessageViewController, user: User) {
        self.showChat(user: user)
    }
}

