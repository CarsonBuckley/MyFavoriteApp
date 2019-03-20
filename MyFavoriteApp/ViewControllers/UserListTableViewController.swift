//
//  UserListTableViewController.swift
//  MyFavoriteApp
//
//  Created by Carson Buckley on 3/20/19.
//  Copyright © 2019 Launch. All rights reserved.
//

import UIKit

class UserListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UserController.shared.getUsers { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserController.shared.users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)

        let user = UserController.shared.users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.favoriteApp

        return cell
    }
    
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        //Creates an Alert that pops up
        let alertController = UIAlertController(title: "Add a new User", message: nil, preferredStyle: .alert)
        
        //Two Textfields
        alertController.addTextField { (textField) in
            textField.placeholder = "Add Username here"
        }
        alertController.addTextField { (tf) in
            tf.placeholder = "Add Favorite App Name in here"
        }
        
        //Add Button
        let addAction = UIAlertAction(title: "Add Alert", style: .default) { (_) in
            guard let name = alertController.textFields?[0].text,
                let favApp = alertController.textFields?[1].text else { return }
            
            UserController.shared.postUser(name: name, favoriteApp: favApp, completion: { (success) in
                if success {
                    print("Successfully created a New User")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
        }
        //Cancel Button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        //Add Actions
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
