//
//  SearchViewController.swift
//  github
//
//  Created by Chung Tran on 22/07/2018.
//  Copyright © 2018 Chung Tran. All rights reserved.
//

import UIKit
import SDWebImage
import DZNEmptyDataSet

enum RepositoriesTableState {
    case empty, searching, noResult, normal
}

class SearchViewController: UITableViewController {
    // MARK: - Properties
    @IBOutlet weak var searchBar: UISearchBar!
    var repositories = [Repository]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var tableViewState = RepositoriesTableState.empty

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        tableView.estimatedRowHeight = 103
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.emptyDataSetSource = self
        
        // A trick to remove separation in empty tableView
        tableView.tableFooterView = UIView()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailVC",
            let repository = sender as? Repository{
            let vc = segue.destination as! RepositoryDetailViewController
            vc.repository = repository
        }
    }
 

}
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else {
            return
        }
        // Reset result array
        repositories = []
        tableViewState = .searching
        tableView.reloadData()
        
        // Call API
        API.searchForReposWithKeyword(keyword, completion: { (repositories) in
            if repositories.count == 0 {self.tableViewState = .noResult}
            else {self.tableViewState = .normal}
            self.repositories = repositories
        }) { (error) in
            self.tableViewState = .noResult
            let alert = UIAlertController(title: "Ошибка", message: "Возникла ошибка \(error.localizedDescription)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        }
        
        // Release keyboard
        searchBar.resignFirstResponder()
    }
}
// MARK: - tableView's delegate & dataSource
extension SearchViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? RepositoryCell {
            let repo = repositories[indexPath.row]
            cell.nameLabel.text = repo.name
            cell.descriptionLabel.text = repo.description
            cell.ownerNameLabel.text = repo.owner.login
            cell.starCountLabel.text = "\(repo.starCount)"
            
            cell.ownerAvatarImageView.sd_setImage(with: URL(string: repo.owner.avatarURL), placeholderImage: UIImage(named: "avatar-default"))
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToDetailVC", sender: repositories[indexPath.row])
    }
}

extension SearchViewController: DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        var text: String
        switch tableViewState {
        case .empty:
            text = "Type something to search!"
        case .noResult:
            text = "No repository found!"
        case .searching:
            text = "Searching..."
        default:
            text = ""
        }
        
        return NSAttributedString(string: text, attributes: [
            NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 18.0)!,
            NSAttributedStringKey.foregroundColor: UIColor.darkGray])
    }
}
