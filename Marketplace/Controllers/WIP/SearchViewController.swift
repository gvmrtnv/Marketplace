//
//  SearchViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 23.01.22.
//

import UIKit

class SearchViewController: UITableViewController {

    @IBOutlet var searchBar: UISearchBar!
    
    var users: [Person]?
    var filteredUsers: [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        DatabaseManager.shared.getUsers { users in
            self.users = users
            self.filteredUsers = users
            self.tableView.reloadData()
        }
        

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Person", for: indexPath) as? PersonTableViewCell else {
        fatalError("Unable to dequeue PersonCell")
        }
        cell.photo.image = nil
        let user = filteredUsers![indexPath.row]
        cell.userName.text = user.username
        cell.fullName.text = ("\(user.name) \(user.secondName)")
        cell.photo.kf.setImage(
            with: user.profilePhoto,
            placeholder: UIImage(systemName: "person.crop.circle.badge.questionmark")
        )
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Person", for: indexPath) as? PersonTableViewCell else {
        fatalError("Unable to dequeue PersonCell")
        }
        cell.photo.kf.cancelDownloadTask()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "PersonView") as? PersonViewController else {return}
        vc.person = filteredUsers![indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredUsers = searchText.isEmpty ? users : users?.filter({ person in
            return person.username.range(of: searchText, options: .caseInsensitive) != nil
        })
        tableView.reloadData()
    }
}

