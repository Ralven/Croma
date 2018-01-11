//
//  AboutUsTableViewController.swift
//  Croma
//
//  Created by Rafael Aguilera on 10/29/17.
//  Copyright © 2017 Rafael Aguilera. All rights reserved.
//

import UIKit

class AboutUsTableViewController: UITableViewController {
    //MARK: Properties
    var users = [User]()
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: TableView Extension for AboutUsTableViewController
extension AboutUsTableViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AboutUsTableViewCell", for: indexPath) as? AboutUsTableViewCell  else {
            fatalError("The dequeued cell is not an instance of AboutUsTableViewCell.")
        }

        return cell
    }
    
}

//MARK: Style Overrides for AboutUsTableViewController
extension AboutUsTableViewController{
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
