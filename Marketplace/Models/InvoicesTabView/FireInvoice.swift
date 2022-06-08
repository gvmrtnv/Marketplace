//
//  FireInvoice.swift
//  Influencer
//
//  Created by Gleb Martynov on 13.03.22.
//

import Foundation

public struct FireInvoice {
    var invId: String
    var title: String
    var url: URL
}

extension FireInvoice {
    init? (id: String, info: [String:Any]) {
        guard let title = info["title"] as? String,
              let urlString = info["url"] as? String,
              let url = URL(string: urlString)
        else {return nil}
        self.init(invId: id, title: title, url: url)
    }
}
