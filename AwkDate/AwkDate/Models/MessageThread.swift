//
//  MessageThread.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 4/30/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation

import MessageKit
import Firebase

class MessageThread: Codable, Equatable {
    
    
    enum CodingKeys: String, CodingKey {
        case identifier
        case title
        case messages
    }
    
    let title: String
    var messages: [MessageThread.Message]
    var identifier: String
    
    init(title: String, messages: [MessageThread.Message] = [], identifier: String = UUID().uuidString) {
        self.title = title
        self.messages = messages
        self.identifier = identifier
    }
    
    
    
    // MARK: - Equatable Conformance
    static func ==(lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title &&
            lhs.identifier == rhs.identifier &&
            lhs.messages == rhs.messages
    }
    
    
    struct Message: Codable, Equatable, MessageType {
        
        let text: String
        let senderName: String
        let timestamp: Date
        let messageId: String
        
        enum CodingKeys: String, CodingKey {
            case text
            case senderName
            case timestamp
            case messageId
        }
        
        // MARK: - MessageType
        var sentDate: Date { return timestamp }
        var kind: MessageKind { return .text(text) }
        var sender: Sender { return Sender(id: senderName, displayName: senderName) }
        
        init(text: String, senderName: String, timestamp: Date = Date(), messageId: String = UUID().uuidString) {
            self.text = text
            self.senderName = senderName
            self.timestamp = timestamp
            self.messageId = messageId
            
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            let text = try container.decode(String.self, forKey: .text)
            let senderName = try container.decode(String.self, forKey: .senderName)
            let timestamp = try container.decode(Date.self, forKey: .timestamp)
            
            self.init(text: text, senderName: senderName, timestamp: timestamp)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(senderName, forKey: .senderName)
            try container.encode(timestamp, forKey: .timestamp)
            try container.encode(text, forKey: .text)
        }
        
        // MARK: - Equatable Conformance
        static func == (lhs: MessageThread.Message, rhs: MessageThread.Message) -> Bool {
            return lhs.text == rhs.text &&
                lhs.senderName == rhs.senderName &&
                lhs.timestamp == rhs.timestamp
        }
        
    }
    
}

