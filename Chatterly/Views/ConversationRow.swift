//
//  ConversationRow.swift
//  Chatterly
//
//  Created by yash bobade on 16/10/25.
//

import SwiftUI

struct ConversationRow: View {
	let conversation: Conversation
	
	// Date formatter
	private var dateFormatter: DateFormatter {
		let formatter = DateFormatter()
		formatter.dateStyle = .short
		formatter.timeStyle = .short
		return formatter
	}
	
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
				
				Text(conversation.lastMessage ?? "no messages yet")
					.font(.caption)
					.foregroundColor(.secondary)
					.lineLimit(1)
			}
			
			Spacer()
			
			// Convert Date to String
			Text(dateFormatter.string(from: conversation.timestamp))
				.font(.caption2)
				.foregroundColor(.secondary)
		}
		.padding(.vertical, 4)
	}
}

