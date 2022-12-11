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
    }
    private func layout(){
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
