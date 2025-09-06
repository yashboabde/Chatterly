//
//  ConversationViewModel.swift
//  Chatterly
//
//  Created by yash bobade on 20/11/25.
//

import Foundation


import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class ConversationViewModel: ObservableObject {
	@Published var conversations: [Conversation] = []
	
	private var db = Firestore.firestore()
	
	init() {
		fetchConversations()
	}
	
	func fetchConversations() {
		db.collection("conversations")
			.order(by: "timestamp", descending: true) // latest first
			.addSnapshotListener { [weak self] snapshot, error in
				guard let documents = snapshot?.documents else {
					print("No documents: \(error?.localizedDescription ?? "")")
					return
				}
				
				self?.conversations = documents.compactMap { doc in
					try? doc.data(as: Conversation.self)
				}
			}
	}
}
