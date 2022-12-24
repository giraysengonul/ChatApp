//
//  MessageCell.swift
//  ChatApp
//
//  Created by hakkı can şengönül on 24.12.2022.
//

import UIKit
import SDWebImage
class MessageCell: UITableViewCell {
    // MARK: - Properties
    var lastUser: LastUser?{
        didSet{ configureMessageCell() }
    }
    private let profileImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    private let lastMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    private var stackView = UIStackView()
    private let timesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.text = "5:5"
        return label
    }()
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Helpers
extension MessageCell{
    private func setup(){
        profileImageview.translatesAutoresizingMaskIntoConstraints = false
        profileImageview.layer.cornerRadius = 55 / 2
        stackView = UIStackView(arrangedSubviews: [usernameLabel, lastMessageLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        timesLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        addSubview(profileImageview)
        addSubview(stackView)
        addSubview(timesLabel)
        NSLayoutConstraint.activate([
            profileImageview.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            profileImageview.heightAnchor.constraint(equalToConstant: 55),
            profileImageview.widthAnchor.constraint(equalToConstant: 55),
            
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: profileImageview.trailingAnchor, constant: 8),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 12),
            
            timesLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            trailingAnchor.constraint(equalTo: timesLabel.trailingAnchor,constant: 8)
            
        ])
    }
    private func configureMessageCell(){
        guard let lastUser = self.lastUser else { return }
        let viewModel = MessageViewModel(lastUser: lastUser)
        self.usernameLabel.text = lastUser.user.username
        self.lastMessageLabel.text = lastUser.message.text
        self.profileImageview.sd_setImage(with: viewModel.profileImage)
        self.timesLabel.text = viewModel.timestampString
    }
}
