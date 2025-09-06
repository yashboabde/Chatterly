//
//  ChatView.swift
//  Chatterly
//
//  Created by yash bobade on 16/10/25.
//

import SwiftUI

struct ChatView: View {
	let conversation: Conversation
	@State private var messageText = ""
	@State private var messages: [Message] = [
		Message(id: "1", text: "Hey there!", isFromCurrentUser: false, timestamp: Date()),
		Message(id: "2", text: "Hi! How are you doing?", isFromCurrentUser: true, timestamp: Date())
	]
	
	var body: some View {
		VStack {
			ScrollView {
				LazyVStack(spacing: 8) {
					ForEach(messages) { message in
						MessageBubble(message: message)
					}
				}
				.padding()
			}
			
			HStack {
				TextField("Type a message...", text: $messageText)
					.textFieldStyle(RoundedBorderTextFieldStyle())
				
				Button("Send") {
					sendMessage()
				}
				.disabled(messageText.trimmingCharacters(in: .whitespaces).isEmpty)
			}
			.padding()
		}
		.navigationTitle(conversation.name)
		.navigationBarTitleDisplayMode(.inline)
	}
	
	private func sendMessage() {
		guard !messageText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
		
		let newMessage = Message(
			id: UUID().uuidString,
			text: messageText,
			isFromCurrentUser: true,
			timestamp: Date()
		)
		
		messages.append(newMessage)
		messageText = ""
	}
}
