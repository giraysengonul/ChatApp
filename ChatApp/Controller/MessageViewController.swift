//
//  MessageViewController.swift
//  ChatApp
//
//  Created by hakkı can şengönül on 18.12.2022.
//

import UIKit
private let reuseIdentifier = "MessageCell"
protocol MessageViewControllerProtocol: AnyObject {
    func showChatViewController(_ messageViewController: MessageViewController, user: User )
}
class MessageViewController: UIViewController{
    // MARK: - Properties
    weak var delegate: MessageViewControllerProtocol?
    private var lastUsers = [LastUser]()
    private let tableView = UITableView()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLastUsers()
        style()
        layout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchLastUsers()
    }
    // MARK: - Service
    private func fetchLastUsers(){
        Service.fetchLastUsers { lastUsers in
            self.lastUsers = lastUsers
            self.tableView.reloadData()
        }
    }
}
// MARK: - Helpers
extension MessageViewController{
    private func style(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MessageCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    private func layout(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
// MARK: - UItableViewDelegate/DataSource
extension MessageViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lastUsers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        cell.lastUser = lastUsers[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.showChatViewController(self, user: lastUsers[indexPath.row].user)
    }
}
