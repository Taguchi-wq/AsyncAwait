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
    private let indicator = UIActivityIndicatorView()
    
    
    // MARK: - @IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView(tableView)
        setupIndicator(indicator)
        fetchUsers()
    }
    
    
    // MARK: - Methods
    private func setupTableView(_ tableView: UITableView) {
        tableView.dataSource = self
    }
    
    private func setupIndicator(_ indicator: UIActivityIndicatorView) {
        indicator.center = view.center
        indicator.style  = .large
        indicator.color  = .gray
        view.addSubview(indicator)
    }
    
    private func fetchUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        indicator.startAnimating()
        Task {
            let result = await NetworkManager.shared.fetch(url, type: [User].self)
            reloadUI(result)
        }
    }

    private func reloadUI(_ result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            self.users = users
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.indicator.stopAnimating()
            }
        case .failure(let error):
            print(error)
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
