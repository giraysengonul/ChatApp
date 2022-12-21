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
        style()
        layout()
    }
    
    override var inputAccessoryView: UIView?{
        get{ return chatInputView }
    }
    override var canBecomeFirstResponder: Bool{
        return true
    }
}
 // MARK: - Helpers
extension ChatViewController{
    private func style(){
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    private func layout(){
        
    }
}
 // MARK: - UIColllectionviewDelegate/DataSource
extension ChatViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .yellow
        return cell
    }
}
extension ChatViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 60)
    }
}
