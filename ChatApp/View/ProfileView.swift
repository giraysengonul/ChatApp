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
    private let gradient = CAGradientLayer()
    private let profileImageView:UIImageView = {
        let imageVİew = UIImageView()
        imageVİew.clipsToBounds = true
        imageVİew.contentMode = .scaleAspectFill
        imageVİew.backgroundColor = .lightGray
        return imageVİew
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .white
        label.text = "name label"
        return label
    }()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .white
        label.text = "username label"
        return label
    }()
    private let signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SignOut", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.systemRed
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    private lazy var stackView = UIStackView()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
}
// MARK: - Helpers
extension ProfileView{
    private func style(){
        clipsToBounds = true
        gradient.locations = [0,1]
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemPink.cgColor]
        layer.addSublayer(gradient)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 120 / 2
        
        stackView = UIStackView(arrangedSubviews: [nameLabel, usernameLabel,signOutButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
    }
    private func layout(){
        addSubview(profileImageView)
        addSubview(stackView)
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 12),
            
        ])
        
    }
    private func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Service.fetchUser(uid: uid) { user in
            print(user.username)
        }
    }
}
