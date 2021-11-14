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
    }
    
    
    // MARK: - Methods
    private func setupTableView(_ tableView: UITableView) {
        tableView.dataSource = self
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
