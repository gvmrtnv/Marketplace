//
//  DatabaseManager.swift
//  Influencer
//
//  Created by Gleb Martynov on 16.01.22.
//
import FirebaseAuth
import FirebaseDatabase
import Foundation

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    
    
    // MARK: - User Data
    
    /// Check if username and email is available
    /// - Parameters:
    ///     - email: String representing email
    ///     - username: String representing username
    public func canCreateNewUser(with email:String, completion: (Bool)->Void) {
        completion(true)
    }
    
    /// Inserts new user data to database
    /// - Parameters:
    ///     - email: String representing email
    ///     - username: String representing username
    ///     - completion: Async callback for result if database entry succeeded
    public func insertNewUser(with email:String, userId:String, completion: @escaping (Bool)-> Void) {
        database.child("users").child(userId).setValue(["email":email]) { error, _ in
            if error == nil {
                completion(true)
                return
            }
            else {
                completion(false)
                return
            }
        }
    }
    
    public func getUserDataOnce(completion: @escaping (Person)->Void) {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        database.child("users").child(userID).observeSingleEvent(of: .value, with: {snapshot in
            guard let infos = snapshot.value as? [String:Any],
                  let user = Person(id: userID, infos)
            else {return}
            completion(user)
        }) { error in
            print(error.localizedDescription)
        }
    }
    
    public func getUser(withID userID:String, completion: @escaping (Person) ->Void) {
        database.child("users").child(userID).observeSingleEvent(of: .value, with: {snapshot in
            guard let infos = snapshot.value as? [String:Any],
                  let user = Person(id: userID, infos)
            else {return}
            completion(user)
        }) { error in
            print(error.localizedDescription)
        }
    }
    
    
    public func getUsers(completion: @escaping ([Person])->Void) {
        database.child("users").observe(.value, with: {snapshot in
            guard let value = snapshot.value as? [String:Any] else {return}
            var users = [Person]()
            value.forEach { uid, infos in
                guard let infos = infos as? [String:Any],
                      let user = Person(id: uid, infos)
                else {return}
                users.append(user)
            }
            completion(users)
        }) { error in
            print(error.localizedDescription)
        }
    }
    
    public func updateUserData(with update: [String:Any]) {
        database.updateChildValues(update)
    }
    
 
    

    // MARK: - Manager requests
    
    public func sendManagerRequest(to uid:String) {
        guard let myID = Auth.auth().currentUser?.uid else {return}
        let update = ["/users/\(myID)/outrequests/\(uid)":true,
                      "/users/\(uid)/inrequests/\(myID)":true
                      ]
        database.updateChildValues(update)
    }
    
    // TO DO: two cases for manager and client
    public func acceptManagerRequest(to uid:String) {
        guard let myID = Auth.auth().currentUser?.uid else {return}
        let update: [String:Any?] = ["/users/\(myID)/outrequests/\(uid)":nil,
                      "/users/\(uid)/inrequests/\(myID)":nil,
                      "/users/\(myID)/inrequests/\(uid)":nil,
                      "/users/\(uid)/outrequests/\(myID)":nil,
                      "/users/\(myID)/manager":uid,
                      "/users/\(uid)/clients/\(uid)":true
                    ]
        database.updateChildValues(update)
    }
    public func declineManagerRequest(to uid:String) {
        guard let myID = Auth.auth().currentUser?.uid else {return}
        let update: [String:Any?] = ["/users/\(myID)/outrequests/\(uid)":nil,
                      "/users/\(uid)/inrequests/\(myID)":nil,
                      "/users/\(myID)/inrequests/\(uid)":nil,
                      "/users/\(uid)/outrequests/\(myID)":nil,
                    ]
        database.updateChildValues(update)
    }
    
    
    // MARK: - Chat
    
    public func createChat(with uid:String) {
        guard let myID = Auth.auth().currentUser?.uid,
              let chatID = database.child("chats").childByAutoId().key
        else {return}
        let update = ["/chats/\(chatID)/users/\(myID)":true,
                      "/chats/\(chatID)/users/\(uid)":true,
                      "/users/\(myID)/chats/\(chatID)":true,
                      "/users/\(uid)/chats/\(chatID)":true
                    ]
        database.updateChildValues(update)
    }
    
    public func insertMessage(_ message:Message, inChat chatId: String) {
        let senderId = message.senderId
        let sentDate = message.sentDate.timeIntervalSince1970
        let senderFullName = message.senderFullName
        let messageId = message.messageId
        let text = message.text
        let imageUrl = message.imageUrl?.absoluteString
        let message: [String:Any] = ["senderId": senderId,
                                     "sentDate": sentDate,
                                     "senderFullName": senderFullName,
                                     "text": text,
                                     "imageUrl": imageUrl
                                    ]
        let update = ["/chats/\(chatId)/thread/\(messageId)":message]
        database.updateChildValues(update)
    }
    
    public func getChats(completion: @escaping ([Chat])->Void) {
        guard let myID = Auth.auth().currentUser?.uid else {return}
        database.child("users/\(myID)/chats").observe(.value, with: { snapshot in
            guard let myChats = snapshot.value as? [String:Any] else {return}
            var chats = [Chat]()
            let myChatsIds = Array(myChats.keys)
            let fireGroup = DispatchGroup()
            let chatQueue = DispatchQueue(label:"chat.serial.queue")
            myChatsIds.forEach({ chatId in
                fireGroup.enter()
                self.database.child("chats").queryOrderedByKey().queryEqual(toValue: chatId).observeSingleEvent(of: .value) {chatsSnap in
                    guard let chatsDict = chatsSnap.value as? [String:Any],
                          let chatInfos = chatsDict.first?.value as? [String:Any]
                    else {
                        fireGroup.leave()
                        return
                    }
                    if let chat = Chat(id: chatId, chatInfos) {
                        chatQueue.async {
                            chats.append(chat)
                        }
                    }
                    fireGroup.leave()
                }
            })
            fireGroup.notify(queue: .main) {
                completion(chats)
            }
        }) { error in
            print(error.localizedDescription)
        }
    }
    
    
    // MARK: - Collabs
    
    public func saveCollab(_ collab : Collab, in cfid: String, completion: (String) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        let database = Database.database().reference()
        
        guard let collabKey = database.child("/lists/\(userID)/\(cfid)").childByAutoId().key else {return}
        var update = ["/lists/\(userID)/\(cfid)/\(collabKey)/colTitle": collab.colTitle,
                      "/lists/\(userID)/\(cfid)/\(collabKey)/revard": collab.revard,
                      "/lists/\(userID)/\(cfid)/\(collabKey)/note": collab.note,
                      "/lists/\(userID)/\(cfid)/\(collabKey)/deadline": collab.deadline,
                      "/lists/\(userID)/\(cfid)/\(collabKey)/brand": collab.brand,
                      "/lists/\(userID)/\(cfid)/\(collabKey)/platforms": collab.platforms,
                      "/lists/\(userID)/\(cfid)/\(collabKey)/approvalNeeded": collab.approvalNeeded,
                      "/lists/\(userID)/\(cfid)/\(collabKey)/managerFee": collab.managerFee,
                      "/lists/\(userID)/\(cfid)/\(collabKey)/files": collab.files
        ] as [String : Any]

        collab.content?.forEach({ content in
            let title = content.title.replacingOccurrences(of: "/", with: "-")
            update["/lists/\(userID)/\(cfid)/\(collabKey)/content/\(title)"] = content.number
        })
        
        database.updateChildValues(update)
        completion(collabKey)
    }

    public func getUserLists(completion: @escaping ([CollabFolder])->Void) {
        guard let myID = Auth.auth().currentUser?.uid else {return}
        
        database.child("lists/\(myID)").observe(.value, with: {snapshot in
            var lists = [CollabFolder]()
            guard let value = snapshot.value as? [String:Any] else {
                completion(lists)
                return
            }
            
            value.forEach { lid, infos in
                guard let infos = infos as? [String:Any],
                      let list = CollabFolder(id: lid, infos)
                else {return}
                lists.append(list)
            }
            completion(lists)
            
        }) { error in
            print(error.localizedDescription)
        }
        
    }
    
    public func getUserCollabFolder(withId collabFolderId: String, completion: @escaping (CollabFolder?)->Void) {
        guard let myID = Auth.auth().currentUser?.uid else {return}
        
        database.child("lists/\(myID)/\(collabFolderId)").observe(.value, with: {snapshot in
            guard let value = snapshot.value as? [String:Any] else {return}
            let collabFolder = CollabFolder(id: collabFolderId, value)
            completion (collabFolder)
            
        }) { error in
            print(error.localizedDescription)
        }
        
    }
    
    
    // MARK: - Invoices
    
    public func getUserInvoices(completion: @escaping ([FireInvoice])->Void) {
        guard let myID = Auth.auth().currentUser?.uid else {return}
        
        database.child("invoices/\(myID)").observe(.value, with: {snapshot in
            var invoices = [FireInvoice]()
            guard let value = snapshot.value as? [String:Any] else {
                completion(invoices)
                return
            }
            
            value.forEach { invId, infos in
                guard let infos = infos as? [String:Any],
                      let invoice = FireInvoice(id: invId, info: infos)
                else {return}
                invoices.append(invoice)
            }
            completion(invoices)
            
        }) { error in
            print(error.localizedDescription)
        }
        
    }
    
    
    
}

