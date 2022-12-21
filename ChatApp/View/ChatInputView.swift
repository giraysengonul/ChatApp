//
//  ChatInputView.swift
//  ChatApp
//
//  Created by hakkı can şengönül on 21.12.2022.
//

import UIKit

class ChatInputView: UIView {
    // MARK: - Properties
    private let textInputView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .title3)
        return textView
    }()
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        return button
    }()
    private let placeHolderLabel:UILabel = {
        let label = UILabel()
        label.text = "Message.."
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
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
extension ChatInputView{
    private func style(){
        autoresizingMask = .flexibleHeight
        configureGradientLayer()
        clipsToBounds = true
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textInputView.translatesAutoresizingMaskIntoConstraints = false
        textInputView.layer.cornerRadius = 10
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputView), name: UITextView.textDidChangeNotification, object: nil)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func layout(){
        addSubview(textInputView)
        addSubview(sendButton)
        addSubview(placeHolderLabel)
        NSLayoutConstraint.activate([
            textInputView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            textInputView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textInputView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -4),
            bottomAnchor.constraint(equalTo: textInputView.bottomAnchor, constant: 16),
            
            sendButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            trailingAnchor.constraint(equalTo: sendButton.trailingAnchor, constant: 8),
            sendButton.heightAnchor.constraint(equalToConstant: 55),
            sendButton.widthAnchor.constraint(equalToConstant: 55),
            
            placeHolderLabel.topAnchor.constraint(equalTo: textInputView.topAnchor),
            placeHolderLabel.leadingAnchor.constraint(equalTo: textInputView.leadingAnchor,constant: 8),
            placeHolderLabel.bottomAnchor.constraint(equalTo: textInputView.bottomAnchor, constant: -8),
            placeHolderLabel.trailingAnchor.constraint(equalTo: textInputView.trailingAnchor)
            
        ])
    }
}
// MARK: - Selector
extension ChatInputView{
    @objc private func handleTextInputView(){
        placeHolderLabel.isHidden = !textInputView.text.isEmpty
    }
}
