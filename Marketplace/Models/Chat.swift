//
//  Chat.swift
//  Influencer
//
//  Created by Gleb Martynov on 31.01.22.
//

import Foundation

public struct Chat {
    var chatId: String
    var users: [String]
    var thread: [Message]?
    
    init? (id chatID: String, _ infos: [String:Any]) {
        guard let usersSnap = infos["users"] as? [String:Any]
        else {return nil}
        
        self.chatId = chatID
         self.users = Array(usersSnap.keys)
        
        if let threadSnap = infos["thread"] as? [String:Any] {
            var thread = [Message]()
            threadSnap.forEach { messageId, infos in
                guard let infos = infos as? [String:Any],
                      let message = Message(id: messageId, infos)
                else {return}
                thread.append(message)
            }
            self.thread = thread
        }
    }
}
