//
//  ChatViewModel.swift
//  Chatterly
//
//  Created by yash bobade on 16/11/25.
//

import Foundation
import FirebaseFirestore

class ChatViewModel: ObservableObject {
	@Published var messages: [Message] = []
	private let db = Firestore.firestore()

	init() {
		fetchMessages()
	}
	
	func fetchMessages() {
		db.collection("messages")
			.order(by: "timestamp", descending: false)
			.addSnapshotListener { snapshot, _ in
				guard let documents = snapshot?.documents else { return }
				self.messages = documents.compactMap { try? $0.data(as: Message.self) }
			}
	}
	
	func sendMessage(text: String, senderId: String) {
		let msg = Message(text: text, senderId: senderId, timestamp: Date())
		do {
			try db.collection("messages").addDocument(from: msg)
		} catch {
			print("Failed to send message: \(error.localizedDescription)")
		}
	}

}
