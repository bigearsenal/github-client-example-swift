//
//  RepositoryDetailViewController.swift
//  github
//
//  Created by Chung Tran on 23/07/2018.
//  Copyright © 2018 Chung Tran. All rights reserved.
//

import UIKit
import SafariServices

class RepositoryDetailViewController: UIViewController {
    var repository: Repository?
    
    @IBOutlet weak var ownerAvatarImage: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let repository = repository {
            ownerAvatarImage.sd_setImage(with: URL(string: repository.owner.avatarURL), placeholderImage: #imageLiteral(resourceName: "avatar-default"))
            ownerNameLabel.text = repository.owner.login
            descriptionLabel.text = repository.description
            descriptionLabel.sizeToFit()
            starCountLabel.text = "\(repository.starCount)"
            title = repository.name
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func ownerLinkDidTouch(_ sender: Any) {
        guard let urlString = repository?.owner.htmlLink,
            let url = URL(string: urlString) else {return}
        openSafariViewControllerWithURL(url)
    }
    
    @IBAction func repositoryLinkDidTouch(_ sender: Any) {
        guard let urlString = repository?.htmlLink,
            let url = URL(string: urlString) else {return}
        openSafariViewControllerWithURL(url)
    }
    
    private func openSafariViewControllerWithURL(_ url: URL) {
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
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
