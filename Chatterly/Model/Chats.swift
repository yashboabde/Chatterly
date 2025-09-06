//
//  Chats.swift
//  Chatterly
//
//  Created by yash bobade on 27/10/25.
//

import Foundation


struct Chat: Identifiable, Codable {
	var id: String
	var name: String
	var members: [String] = [] // user IDs
	var lastMessage: String?
	var timestamp: Date
}
