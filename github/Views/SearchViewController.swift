//
//  SearchViewController.swift
//  github
//
//  Created by Chung Tran on 22/07/2018.
//  Copyright © 2018 Chung Tran. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
    // MARK: - Properties
    @IBOutlet weak var searchBar: UISearchBar!
    var repositories = [Repository]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 103
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - tableView's delegate & dataSource
extension SearchViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? RepositoryCell {
            cell.nameLabel.text = repositories[indexPath.row].name
            cell.descriptionLabel.text = repositories[indexPath.row].description
            cell.ownerNameLabel.text = repositories[indexPath.row].owner.login
            cell.starCountLabel.text = "\(repositories[indexPath.row].starCount)"
            cell.ownerAvatarImageView = UIImageView(image: UI)
        }
    }
    
}
