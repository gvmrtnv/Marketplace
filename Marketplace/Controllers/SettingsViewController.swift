//
//  SettingsViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 18.01.22.
//

import UIKit

struct CellModel {
    var title:String
    var handler:(()->Void)
}

class SettingsViewController: UITableViewController {
    
    var data = [[CellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        self.title = "Settings"
        

        
    }
    private func configureModels() {
        let section = [
            CellModel(title: "Account Info", handler: { [weak self] in
                self?.showAccountInfo()
        }),
            CellModel(title: "LogOut", handler: { [weak self] in
            self?.logOut()
        })
        ]
        data.append(section)
    }
    private func logOut() {
        let actionSheet = UIAlertController(title: "Are you sure?", message: "Do you want to log out?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "LogOut", style: .destructive, handler: { _ in
            AuthManager.shared.logoutUser { success in
                if success {
                    let vc = LoginViewController()
                    let navVC = UINavigationController(rootViewController: vc)
                    let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                    delegate?.changeRootViewController(navVC, animated: true)
                }
                else {
                    fatalError("Could not log out user")
                }
            }
        }))
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        
        present(actionSheet, animated: true)
    }
    private func showAccountInfo() {
        let vc = InfluencerAccountInfoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Setting", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        data[indexPath.section][indexPath.row].handler()
    }


}
