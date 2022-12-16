//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by hakkı can şengönül on 12.12.2022.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
class RegisterViewController: UIViewController {
    // MARK: - Properties
    private var profileImageToUpload : UIImage?
    private var viewModel = RegisterViewModel()
    private lazy var addCameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "camera.circle"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(handlePhoto), for: .touchUpInside)
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
    private let usernameTextField = CustomTextField(placeholder: "Username")
    private let nameTextField = CustomTextField(placeholder: "Name")
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    private var stackView = UIStackView()
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.isEnabled = false
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.layer.cornerRadius = 7
        button.addTarget(self, action: #selector(hadleRegisterBuuton), for: .touchUpInside)
        return button
    }()
    private lazy var switchToLoginPage:UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "If you ara a memeber, Login page",attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 14)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(hanleGoToLoginView), for: .touchUpInside)
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}
// MARK: - Selector
extension RegisterViewController{
    @objc private func hadleRegisterBuuton(_ sender: UIButton){
        guard let emailText = emailTextField.text else{ return }
        guard let nameText = nameTextField.text else{ return }
        guard let usernameText = usernameTextField.text else{ return }
        guard let passwordText = passwordTextField.text else{ return }
        guard let profileImage = profileImageToUpload else{ return }
        let user = AuthenticationServiceUser(emailText: emailText, passwordText: passwordText, nameText: nameText, usernameText: usernameText)
        self.showProgressHud(showProgress: true)
        AuthenticationService.register(withUser: user, image: profileImage) { error in
            if let error = error{
                print("Error: \(error.localizedDescription)")
                self.showProgressHud(showProgress: false)
                return
            }
            self.showProgressHud(showProgress: false)
            self.dismiss(animated: true)
        }
        
        
    }
    @objc private func handleTextFieldChange(_ sender: UITextField){
        if sender == emailTextField{
            viewModel.email = sender.text
        }else if sender == nameTextField{
            viewModel.name = sender.text
        }else if sender == usernameTextField{
            viewModel.userName = sender.text
        }else{
            viewModel.password = sender.text
        }
        registerButtonStatus()
    }
    @objc func hanleGoToLoginView(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @objc private func handlePhoto(_ sender: UIButton){
        let picker = UIImagePickerController()
        picker.delegate = self
        self.present(picker, animated: true)
    }
}
// MARK: - Helpers
extension RegisterViewController{
    private func registerButtonStatus(){
        if viewModel.status{
            registerButton.isEnabled = true
            registerButton.backgroundColor = .systemBlue
        }else{
            registerButton.isEnabled = false
            registerButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
    @objc private func handleWillShowNotification(){
        self.view.frame.origin.y = -110
    }
    @objc private func handleWillHideNotification(){
        self.view.frame.origin.y = 0
    }
    private func configureSetupKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleWillShowNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleWillHideNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    private func style(){
        configureGradientLayer()
        configureSetupKeyboard()
        self.navigationController?.navigationBar.isHidden = true
        //addCameraButton
        addCameraButton.translatesAutoresizingMaskIntoConstraints = false
        //stackView
        stackView = UIStackView(arrangedSubviews: [emailContainerView,nameContainerView,usernameContainerView ,passwordContainerView, registerButton])
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //textDidChange
        emailTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        //switchToLoginPage
        switchToLoginPage.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        view.addSubview(addCameraButton)
        view.addSubview(stackView)
        view.addSubview(switchToLoginPage)
        NSLayoutConstraint.activate([
            addCameraButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            addCameraButton.heightAnchor.constraint(equalToConstant: 150),
            addCameraButton.widthAnchor.constraint(equalToConstant: 150),
            addCameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            stackView.topAnchor.constraint(equalTo: addCameraButton.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            switchToLoginPage.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            switchToLoginPage.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 32),
            view.trailingAnchor.constraint(equalTo: switchToLoginPage.trailingAnchor, constant: 32)
            
        ])
    }
}
// MARK: - UIImagePickerControllerDelegate,UINavigationControllerDelegate
extension RegisterViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        self.profileImageToUpload = image
        addCameraButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        addCameraButton.layer.cornerRadius = 150 / 2
        addCameraButton.clipsToBounds = true
        addCameraButton.layer.borderColor = UIColor.white.cgColor
        addCameraButton.layer.borderWidth = 2
        addCameraButton.contentMode = .scaleAspectFill
        dismiss(animated: true)
    }
}
