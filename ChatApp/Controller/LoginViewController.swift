//
//  ViewController.swift
//  ChatApp
//
//  Created by hakkı can şengönül on 10.12.2022.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: - Properties
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "ellipsis.message")
        imageView.tintColor = .white
        return imageView
    }()
    private lazy var emailContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "envelope")!, textField: emailTextField)
        
        return containerView
    }()
    private let emailTextField = CustomTextField(placeholder: "Email")
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGradientLayer()
        style()
        layout()
    }
}
// MARK: - Helpers
extension LoginViewController{
    private func style(){
        //logoImageView
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        emailContainerView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        view.addSubview(logoImageView)
        view.addSubview(emailContainerView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailContainerView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            emailContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emailContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailContainerView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
