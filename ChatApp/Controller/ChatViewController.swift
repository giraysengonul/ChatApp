//
//  ChatViewController.swift
//  ChatApp
//
//  Created by hakkı can şengönül on 21.12.2022.
//

import UIKit

class ChatViewController: UICollectionViewController {
    private lazy var chatInputView = ChatInputView(frame: .init(x: 0, y: 0, width: view.frame.width, height: view.frame.width * 0.2))
    private let user: User
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(user.name)
    }
    
    override var inputAccessoryView: UIView?{
        get{ return chatInputView }
    }
    override var canBecomeFirstResponder: Bool{
        return true
    }
}
