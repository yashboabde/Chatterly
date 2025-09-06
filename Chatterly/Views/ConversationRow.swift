//
//  ConversationRow.swift
//  Chatterly
//
//  Created by yash bobade on 16/10/25.
//

import SwiftUI

struct ConversationRow: View {
	let conversation: Conversation
	
	var body: some View {
		HStack {
			Circle()
				.fill(Color.blue)
				.frame(width: 50, height: 50)
				.overlay(
					Text(conversation.name.prefix(1))
						.foregroundColor(.white)
						.fontWeight(.bold)
				)
			
			VStack(alignment: .leading, spacing: 4) {
				Text(conversation.name)
					.fontWeight(.semibold)
				
				Text(conversation.lastMessage)
					.font(.caption)
					.foregroundColor(.secondary)
					.lineLimit(1)
			}
			
			Spacer()
			
			Text(conversation.timestamp)
				.font(.caption2)
				.foregroundColor(.secondary)
		}
		.padding(.vertical, 4)
	}
}
