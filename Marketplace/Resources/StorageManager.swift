//
//  StorageManager.swift
//  Influencer
//
//  Created by Gleb Martynov on 16.01.22.
//

import FirebaseStorage
import FirebaseAuth
import Foundation
import FirebaseDatabase


public class StorageManager {
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    private let database = Database.database().reference()
    // MARK: - Public
    
    //TO DO: limit upload size
    public func uploadUserFoto(_ image:UIImage) {
        guard let userID = Auth.auth().currentUser?.uid,
        let data = image.jpegData(compressionQuality: 0.4)
        else {return}
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let ref = storage.child("UserProfileFotos").child(userID)
        ref.putData(data, metadata: metadata){ _, error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
        
            ref.downloadURL { url, error in
                guard let url = url else {return}
                let update: [String:Any] = ["/users/\(userID)/profilePhoto": url.absoluteString]
                self.database.updateChildValues(update)
            }
        }
    }
    
    // small = 168*168*32 from size of prifilePictures
    //normal = 168*168*32*5*5
    enum imageSize: Int {
        case small = 903168
        case normal = 22579200
    }
        

    public func uploadInvoice(_ data:Data, withName title: String, forCollab cid: String?, inFolder cfid: String?, completion: @escaping (Bool)-> Void) {
        guard let userID = Auth.auth().currentUser?.uid,
              let invoiceID = database.child("invoices").child(userID).childByAutoId().key
        
        else {return}
        
        let ref = storage.child("invoices").child(userID).child(invoiceID).child(title)
        ref.putData(data, metadata: nil){ _, error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
        
            ref.downloadURL { url, error in
                guard let url = url else {return}

                var update: [String:Any] = ["/invoices/\(userID)/\(invoiceID)/url": url.absoluteString,
                                            "/invoices/\(userID)/\(invoiceID)/title": title
                ]
                if let cid = cid,
                   let cfid = cfid {
                    update["/lists/\(userID)/\(cfid)/\(cid)/files/\(invoiceID)/url"] = url.absoluteString
                    update["/lists/\(userID)/\(cfid)/\(cid)/files/\(invoiceID)/title"] = title
                }
                self.database.updateChildValues(update)
                completion(true)
            }
        }
    }
    
}

