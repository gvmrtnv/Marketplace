//
//  CollabFolder.swift
//  Influencer
//
//  Created by Gleb Martynov on 18.02.22.
//

import Foundation
public struct CollabFolder {
    var title: String
    var collabs: [Collab]?
    var cfid: String?
}


extension CollabFolder {
    init? (id cfid: String, _ infos: [String:Any]) {
        guard let title = infos["title"] as? String
        else {return nil}
        var newCollabs = [Collab]()
        
        infos.forEach { key, value in
            guard let value = value as? [String:Any],
                  let collab = Collab(id: key, value)
            else {return}
            newCollabs.append(collab)
        }
        
        
        self.init(title: title, collabs: newCollabs, cfid: cfid)

    }

}
