//
//  Conversation.swift
//  Chatterly
//
//  Created by yash bobade on 16/10/25.
//

import Foundation
import FirebaseFirestore

struct Conversation: Identifiable, Codable {
	@DocumentID var id: String?
	let name: String
	let participants: [String]
	let lastMessage: String?
	let timestamp: Date
}
