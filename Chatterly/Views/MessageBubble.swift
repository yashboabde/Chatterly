//
//  MessageBubble.swift
//  Chatterly
//
//  Created by yash bobade on 16/10/25.
//

import SwiftUI

struct MessageBubble: View {
	let message: Message
	
	var body: some View {
		HStack {
			if message.isFromCurrentUser {
				Spacer()
			}
			
			VStack(alignment: message.isFromCurrentUser ? .trailing : .leading, spacing: 4) {
				Text(message.text)
					.padding(.horizontal, 12)
					.padding(.vertical, 8)
					.background(message.isFromCurrentUser ? Color.blue : Color.gray.opacity(0.2))
					.foregroundColor(message.isFromCurrentUser ? .white : .primary)
					.cornerRadius(12)
				
				Text(message.timestamp, style: .time)
					.font(.caption2)
					.foregroundColor(.secondary)
			}
			
			if !message.isFromCurrentUser {
				Spacer()
			}
		}
	}
}
