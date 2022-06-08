//
//  File.swift
//  Influencer
//
//  Created by Gleb Martynov on 30.01.22.
//

import Foundation
import MessageKit

public struct Message: MessageType {
    
    public var senderId: String
    public var senderFullName: String
    public var imageUrl: URL?
    public var sender: SenderType {
        return ChatUser(senderId: senderId, displayName: senderFullName, imageUrl: imageUrl)
    }
    public var messageId: String
    public var sentDate: Date
    public var text: String
    public var kind: MessageKind {
        return .text(text)
    }
}

extension Message {
    init? (id messageId: String, _ infos: [String:Any]) {
        guard let text = infos["text"] as? String,
              let sentInterval = infos["sentDate"] as? TimeInterval,
              let senderId = infos["senderId"] as? String,
              let senderFullName = infos["senderFullName"] as? String
        else {return nil}
        let sentDate = Date(timeIntervalSince1970: sentInterval)
        if let imageString = infos["imageUrl"] as? String {
            let imageUrl = URL(string: imageString)
            self.init(senderId: senderId, senderFullName: senderFullName, imageUrl: imageUrl, messageId: messageId, sentDate: sentDate, text: text)
        }
        else {
        self.init(senderId: senderId, senderFullName: senderFullName, messageId: messageId, sentDate: sentDate, text: text)
        }
    }
}


