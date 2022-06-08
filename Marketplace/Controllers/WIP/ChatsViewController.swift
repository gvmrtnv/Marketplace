//
//  ChatsViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 30.01.22.
//

import UIKit
import FirebaseAuth

class ChatsViewController: UIViewController {
    
    var chats: [Chat]?
    let myId = Auth.auth().currentUser?.uid
    
    @IBOutlet var chatsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatabaseManager.shared.getChats { chats in
            self.chats = chats
            self.chatsTable.reloadData()
        }
        chatsTable.dataSource = self
        chatsTable.delegate = self
    }
    

    
    
    
    @IBAction func newChatdidTapped(_ sender: Any) {
        DatabaseManager.shared.createChat(with: "92xouiuZAZYgh9ACqA2tv1njECr2")
    }
    
}

extension ChatsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "chat", for: indexPath) as? ChatTableViewCell,
              let userId = chats![indexPath.row].users.filter{$0 != myId}.first
        else {
            fatalError("Unable to deque ChatTableViewCell")
        }
        DatabaseManager.shared.getUser(withID: userId) { user in
            DispatchQueue.main.async {
                cell.fullName.text = user.username
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let myId  = myId else {return}
        DatabaseManager.shared.getUser(withID: myId) { currentUser in
            let vc = ChatViewController()
            vc.chat = self.chats![indexPath.row]
            vc.currentUser = currentUser
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
