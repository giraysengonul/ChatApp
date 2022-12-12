//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by hakkı can şengönül on 12.12.2022.
//

import UIKit

class RegisterVİewController: UIViewController {
    // MARK: - Properties
    private let addCameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "camera.circle"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    private lazy var emailContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "envelope")!, textField: emailTextField)
        return containerView
    }()
    private lazy var nameContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "person")!, textField: nameTextField)
        return containerView
    }()
    private lazy var usernameContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "person")!, textField: usernameTextField)
        return containerView
    }()
    private lazy var passwordContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "lock")!, textField: passwordTextField)
        return containerView
    }()
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let usernameTextField = CustomTextField(placeholder: "Name")
    private let nameTextField = CustomTextField(placeholder: "Username")
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    private var stackView = UIStackView()
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.isEnabled = false
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}
// MARK: - Helpers
extension RegisterVİewController{
    private func style(){
        configureGradientLayer()
        self.navigationController?.navigationBar.isHidden = true
        //addCameraButton
        addCameraButton.translatesAutoresizingMaskIntoConstraints = false
        //stackView
        stackView = UIStackView(arrangedSubviews: [emailContainerView,nameContainerView,usernameContainerView ,passwordContainerView, registerButton])
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        view.addSubview(addCameraButton)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            addCameraButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            addCameraButton.heightAnchor.constraint(equalToConstant: 150),
            addCameraButton.widthAnchor.constraint(equalToConstant: 150),
            addCameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            stackView.topAnchor.constraint(equalTo: addCameraButton.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailContainerView.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
    }
}
