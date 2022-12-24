//
//  ChatViewController.swift
//  ChatApp
//
//  Created by hakkı can şengönül on 21.12.2022.
//

import UIKit
private let reuseIdentifier = "MessageCell"
class ChatViewController: UICollectionViewController {
    // MARK: - Properties
    var messages = [Message]()
    private lazy var chatInputView = ChatInputView(frame: .init(x: 0, y: 0, width: view.frame.width, height: view.frame.width * 0.2))
    private let user: User
    // MARK: - Lifecycle
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMessages()
        style()
        layout()
    }
    
    override var inputAccessoryView: UIView?{
        get{ return chatInputView }
    }
    override var canBecomeFirstResponder: Bool{
        return true
    }
    // MARK: - Service
    private func fetchMessages(){
        Service.fetchMessages(user: user) { messages in
            self.messages = messages
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: [0, messages.count-1], at: .bottom, animated: true)
        }
    }
}
// MARK: - Helpers
extension ChatViewController{
    private func style(){
        collectionView.register(NewMessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        chatInputView.delegate = self
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = user.username
    }
    private func layout(){
        
    }
}
// MARK: - UIColllectionviewDelegate/DataSource
extension ChatViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewMessageCell
        cell.message = messages[indexPath.row]
        cell.message?.user = user
        return cell
    }
}
extension ChatViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let fakeCell = NewMessageCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 50))
        fakeCell.message = messages[indexPath.row]
        fakeCell.layoutIfNeeded()
        let target = CGSize(width: view.frame.width, height: 1000)
        let fakeCellSize = fakeCell.systemLayoutSizeFitting(target)
        return .init(width: view.frame.width, height: fakeCellSize.height)
    }
}
// MARK: - ChatInputViewProtocol
extension ChatViewController: ChatInputViewProtocol{
    func sendMessage(_ chatInputView: ChatInputView, message: String) {
        
        Service.sendMessage(message: message, toUser: user) { error in
            if let error = error{
                print("Error: \(error.localizedDescription)")
                return
            }
        }
        chatInputView.clear()
    }
}
