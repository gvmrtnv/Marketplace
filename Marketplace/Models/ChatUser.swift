//
//  ChatUser.swift
//  Influencer
//
//  Created by Gleb Martynov on 31.01.22.
//

import Foundation
import MessageKit

public struct ChatUser: SenderType {
    public var senderId: String
    public var displayName: String
    public var imageUrl: URL?
}
