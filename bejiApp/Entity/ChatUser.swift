//
//  ChatUser.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/12.
//

import Foundation
import MessageKit

public struct ChatUser: SenderType {
    public let senderId: String
    public let displayName: String
    
    init(senderId: String, displayName: String) {
        self.senderId = senderId
        self.displayName = displayName
    }
}
