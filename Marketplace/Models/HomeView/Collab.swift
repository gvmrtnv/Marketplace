//
//  Collab.swift
//  Influencer
//
//  Created by Gleb Martynov on 27.01.22.
//

import Foundation
public struct Collab {
    var colTitle: String
    var revard: String
    var note: String
    var deadline: TimeInterval
    var brand: String
    var platforms: [String]?
    var content: [Content]?
    var approvalNeeded: Bool
    var managerFee: Bool
    var files: [String]?
    var cid: String?
}

extension Collab {
    init? (id cid: String, _ infos: [String:Any]) {
        guard let colTitle = infos["colTitle"] as? String,
              let revard = infos["revard"] as? String,
              let note = infos["note"] as? String,
              let deadline = infos["deadline"] as? TimeInterval,
              let brand = infos["brand"] as? String,
              let approvalNeeded = infos["approvalNeeded"] as? Bool,
              let managerFee = infos["managerFee"] as? Bool
        else {return nil}
        let platforms = infos["platforms"] as? [String]
        var newContent = [Content]()
        if let content = infos["content"] as? [String:Int] {
            content.forEach { key, value in
                let title = key.replacingOccurrences(of: "-", with: "/")
                newContent.append(Content(title: key, number: value))
            }
        }
        
        let files = infos["platforms"] as? [String]
        self.init(colTitle: colTitle, revard: revard, note: note, deadline: deadline, brand: brand, platforms: platforms, content: newContent, approvalNeeded: approvalNeeded, managerFee: managerFee, files: files, cid: cid)
    }

}
