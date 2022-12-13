//
//  message.swift
//  ChatApp
//
//  Created by Apple on 24/09/2022.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
}
