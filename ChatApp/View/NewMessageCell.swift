//
//  MessageCell.swift
//  ChatApp
//
//  Created by hakkı can şengönül on 22.12.2022.
//

import UIKit
import SDWebImage
class NewMessageCell: UICollectionViewCell {
    // MARK: - Properties
    var messageContainerViewLeft: NSLayoutConstraint!
    var messageContainerViewRight: NSLayoutConstraint!
    var message: Message?{
        didSet{ configure() }
    }
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    private let messageContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .systemBlue
        return containerView
    }()
    private let messageTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.font = UIFont.preferredFont(forTextStyle: .title3)
        textView.text = "Message"
        textView.textColor = .white
        return textView
    }()
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
extension NewMessageCell{
    private func style(){
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 34 / 2
        messageContainerView.translatesAutoresizingMaskIntoConstraints = false
        messageContainerView.layer.cornerRadius = 10
        messageContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        addSubview(profileImageView)
        addSubview(messageContainerView)
        addSubview(messageTextView)
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 34),
            profileImageView.heightAnchor.constraint(equalToConstant: 34),
            bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -8),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            
            messageContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            messageContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            messageContainerView.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
            
            messageTextView.topAnchor.constraint(equalTo: messageContainerView.topAnchor),
            messageTextView.leadingAnchor.constraint(equalTo: messageContainerView.leadingAnchor),
            messageTextView.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor),
            messageTextView.bottomAnchor.constraint(equalTo: messageContainerView.bottomAnchor),
        ])
        self.messageContainerViewLeft = messageContainerView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8)
        self.messageContainerViewLeft.isActive = false
        self.messageContainerViewRight = messageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        self.messageContainerViewRight.isActive = false
        
    }
    private func configure(){
        guard let message = self.message else { return }
        let viewModel = NewMessageViewModel(message: message)
        messageTextView.text = message.text
        messageContainerView.backgroundColor = viewModel.messageBackgroundColor
        messageContainerViewRight.isActive = viewModel.currentUserActive
        messageContainerViewLeft.isActive = !viewModel.currentUserActive
        profileImageView.isHidden = viewModel.currentUserActive
        profileImageView.sd_setImage(with: viewModel.profileImageView)
        if viewModel.currentUserActive{
            messageContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
        }else{
            messageContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
    }
}
