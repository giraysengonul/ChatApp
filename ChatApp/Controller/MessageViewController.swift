//
//  MessageViewController.swift
//  ChatApp
//
//  Created by hakkı can şengönül on 18.12.2022.
//

import UIKit
private let reuseIdentifier = "MessageCell"
class MessageViewController: UIViewController{
     // MARK: - Properties
    private var lastUsers = [LastUser]()
    private let tableView = UITableView()
     // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLastUsers()
        style()
        layout()
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}
