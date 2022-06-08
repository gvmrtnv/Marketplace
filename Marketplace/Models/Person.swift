//
//  Person.swift
//  Influencer
//
//  Created by Gleb Martynov on 24.01.22.
//

import Foundation
import MessageKit

public struct Person {
    var name: String
    var username: String
    var uid: String
    var region: String
 
    
    var secondName: String?
    var profilePhoto: URL?
    var gender: String?
    
    var manager: String?
    var inRequests: [String:Bool]?
    var outRequests: [String:Bool]?
    
    init? (id uid:String, _ infos:[String:Any]) {
        guard let name = infos["name"] as? String,
              let username = infos["username"] as? String,
              let region = infos["region"] as? String
      
        else {return nil}
        self.name = name
     
        self.username = username
        self.uid = uid
        self.region = region
     
        
        if let secondName = infos["secondname"] as? String {
            self.secondName = secondName
        }
        
        if let manager = infos["manager"] as? String {
            self.manager = manager
        }
        if let inRequests = infos["inrequests"] as? [String:Bool] {
            self.inRequests = inRequests
        }
        if let outRequests = infos["outrequests"] as? [String:Bool] {
            self.outRequests = outRequests
        }
        if let profilePhoto = infos["profilePhoto"] as? String {
            self.profilePhoto = URL(string: profilePhoto)
        }
        if let gender = infos["gender"] as? String {
            self.gender = gender
        }
    }
        
}
