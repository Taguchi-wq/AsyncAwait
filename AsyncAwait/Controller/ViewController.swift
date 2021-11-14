//
//  ViewController.swift
//  AsyncAwait
//
//  Created by cmStudent on 2021/11/15.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Properties
    private var users: [User] = []
    
    
    // MARK: - @IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView(tableView)
        fetchUsers()
    }
    
    
    // MARK: - Methods
    private func setupTableView(_ tableView: UITableView) {
        tableView.dataSource = self
    }
    
    private func fetchUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        Task {
            let result = await NetworkManager.shared.fetch(url, type: [User].self)
            switch result {
            case .success(let users):
                self.users = users
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }


}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
}
