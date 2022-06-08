//
//  ChatViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 30.01.22.
//
//
import UIKit
import MessageKit
import InputBarAccessoryView
import FirebaseAuth

class ChatViewController: MessagesViewController {
    
    var messages = [Message]()
    var chat: Chat!
    var currentUser: Person!

    override func viewDidLoad() {
        super.viewDidLoad()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
        maintainPositionOnKeyboardFrameChanged = true
        scrollsToLastItemOnKeyboardBeginsEditing  = true
        
        messageInputBar.inputTextView.tintColor = .systemTeal
        messageInputBar.sendButton.setTitleShadowColor(.systemTeal, for: .normal)
        
        
        if let thread = chat.thread {
            messages = thread
        }
        
    }
    
    private func insertNewMessage(_ message: Message) {
        
        messages.append(message)
        messagesCollectionView.reloadData()
        DatabaseManager.shared.insertMessage(message, inChat: chat.chatId)
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
        }
    }
    
    

}

extension ChatViewController: MessagesDataSource, MessagesDisplayDelegate, MessagesLayoutDelegate, InputBarAccessoryViewDelegate {

    func currentSender() -> SenderType {
        let senderId = currentUser.uid
        let displayName = currentUser.username
        let imageUrl = currentUser.profilePhoto
        
        return ChatUser(senderId: senderId, displayName: displayName, imageUrl: imageUrl)
    }

    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        guard let sender = message.sender as? ChatUser,
           let url = sender.imageUrl
        else {return}
        avatarView.kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "person.crop.circle.badge.questionmark")
            )
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
    }

    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let uid = currentUser.uid
        let senderFullName = currentUser.username
        let messageId = UUID().uuidString
        let sentDate = Date()
        let imageUrl = currentUser.profilePhoto
        let message = Message(senderId: uid, senderFullName: senderFullName,imageUrl: imageUrl, messageId: messageId, sentDate: sentDate, text: text)
        insertNewMessage(message)
        inputBar.inputTextView.text = ""
    }

}
